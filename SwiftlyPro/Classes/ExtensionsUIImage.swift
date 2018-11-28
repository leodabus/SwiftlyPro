//
//  ExtensionsUIImage.swift
//  SwiftlyPro
//
//  Created by lsd on 19/11/18.
//

import UIKit
public extension UIImage {
    /// Returns a resized image
    ///
    ///
    /// - Parameters:
    ///     - percentage: Of how much you would like to resize the image
    public func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    public func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

public extension UIImage {
    public var isPortrait:  Bool    { return size.height > size.width }
    public var isLandscape: Bool    { return size.width > size.height }
    public var breadth:     CGFloat { return min(size.width, size.height) }
    public var breadthSize: CGSize  { return CGSize(width: breadth, height: breadth) }
    public var breadthRect: CGRect  { return CGRect(origin: .zero, size: breadthSize) }
    public var circleMasked: UIImage? {
        UIGraphicsBeginImageContextWithOptions(breadthSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let cgImage = cgImage?.cropping(to: CGRect(origin: CGPoint(x: isLandscape ? floor((size.width - size.height) / 2) : 0, y: isPortrait  ? floor((size.height - size.width) / 2) : 0), size: breadthSize)) else { return nil }
        UIBezierPath(ovalIn: breadthRect).addClip()
        UIImage(cgImage: cgImage, scale: 1, orientation: imageOrientation).draw(in: breadthRect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }

    // https://stackoverflow.com/a/33091111/2303865
    // usage:
    //    if let imageURL = URL(string: "https://i.stack.imgur.com/Xs4RX.jpg"),
    //    let data = try? Data(contentsOf: imageURL),
    //    let image = UIImage(data: data) {
    //
    //        let topHalf = image.topHalf
    //        let bottomHalf = image.bottomHalf
    //
    //        let topLeft = topHalf?.leftHalf
    //        let topRight = topHalf?.rightHalf
    //        let bottomLeft = bottomHalf?.leftHalf
    //        let bottomRight = bottomHalf?.rightHalf
    //    }
    public var topHalf: UIImage? {
        guard let cgImage = cgImage, let image = cgImage.cropping(to: CGRect(origin: .zero, size: CGSize(width: size.width, height: size.height/2))) else { return nil }
        return UIImage(cgImage: image, scale: 1, orientation: imageOrientation)
    }
    public var bottomHalf: UIImage? {
        guard let cgImage = cgImage, let image = cgImage.cropping(to: CGRect(origin: CGPoint(x: 0,  y: CGFloat(Int(size.height)-Int(size.height/2))), size: CGSize(width: size.width, height: CGFloat(Int(size.height) - Int(size.height/2))))) else { return nil }
        return UIImage(cgImage: image)
    }
    public var leftHalf: UIImage? {
        guard let cgImage = cgImage, let image = cgImage.cropping(to: CGRect(origin: .zero, size: CGSize(width: size.width/2, height: size.height))) else { return nil }
        return UIImage(cgImage: image)
    }
    public var rightHalf: UIImage? {
        guard let cgImage = cgImage, let image = cgImage.cropping(to: CGRect(origin: CGPoint(x: CGFloat(Int(size.width)-Int((size.width/2))), y: 0), size: CGSize(width: CGFloat(Int(size.width)-Int((size.width/2))), height: size.height)))
            else { return nil }
        return UIImage(cgImage: image)
    }
    
    // usage:
    //    let profilePicture = UIImage(data: try! Data(contentsOf: URL(string:"http://i.stack.imgur.com/Xs4RX.jpg")!))!
    //    if let face =  profilePicture.datectFaces().first {
    //        print(face.size)
    //    }

    public func detectFaces() -> [UIImage] {
        guard let ciimage = CIImage(image: self) else { return [] }
        var orientation: NSNumber {
            switch imageOrientation {
            case .up:            return 1
            case .upMirrored:    return 2
            case .down:          return 3
            case .downMirrored:  return 4
            case .leftMirrored:  return 5
            case .right:         return 6
            case .rightMirrored: return 7
            case .left:          return 8
            }
        }
        return CIDetector(ofType: CIDetectorTypeFace, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyLow])?
            .features(in: ciimage, options: [CIDetectorImageOrientation: orientation])
            .compactMap {
                let rect = $0.bounds.insetBy(dx: -10, dy: -10)
                UIGraphicsBeginImageContextWithOptions(rect.size, false, scale)
                defer { UIGraphicsEndImageContext() }
                UIImage(ciImage: ciimage.cropped(to: rect)).draw(in: CGRect(origin: .zero, size: rect.size))
                guard let face = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
                // now that you have your face image you need to properly apply a circle mask to it
                let size = face.size
                let breadth = min(size.width, size.height)
                let breadthSize = CGSize(width: breadth, height: breadth)
                UIGraphicsBeginImageContextWithOptions(breadthSize, false, scale)
                defer { UIGraphicsEndImageContext() }
                guard let cgImage = face.cgImage?.cropping(to: CGRect(origin: CGPoint(x: size.width > size.height ? (size.width-size.height).rounded(.down)/2 : 0, y: size.height > size.width ? (size.height-size.width).rounded(.down)/2 : 0), size: breadthSize))
                    else { return nil }
                let faceRect = CGRect(origin: .zero, size: CGSize(width: min(size.width, size.height), height: min(size.width, size.height)))
                UIBezierPath(ovalIn: faceRect).addClip()
                UIImage(cgImage: cgImage).draw(in: faceRect)
                return UIGraphicsGetImageFromCurrentImageContext()
            } ?? []
    }
}
