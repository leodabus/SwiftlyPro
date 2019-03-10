//
//  ExtensionsString.swift
//  SwiftlyPro
//
//  Created by lsd on 18/11/18.
//

import Foundation
public extension String {
    public var data: Data {
        return Data(utf8)
        
    }
    public var iso8601: Date? {
        return Formatter.iso8601.date(from: self)   // "Mar 22, 2017, 10:22 AM"
    }
    
    public var foldingAccents: String {
     
        return folding(options: .diacriticInsensitive, locale: .posix)
    }
    
    public var html2AttributedString: NSAttributedString? {
        return data.html2AttributedString
    }
    
    public var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}


extension String {
    struct QRCode {
        /// The lower the error correction level,
        /// the less dense the QR code image is, which improves minimum printing size.
        /// The higher the error correction level,
        /// the more damage it can sustain before it becomes unreadabale.
        ///
        /// Level L or Level M represent the best compromise between density and ruggedness for general marketing use.
        /// Level Q and Level H are generally recommended for industrial environments where keeping the QR code clean or un-damaged will be a challenge.
        enum CorrectionLeveL: String {
            case l = "L", m = "M", q = "Q", h = "H"
        }
    }
    
    /// QRCode Generator
    ///
    ///
    /// - Author: Leonardo Dabus
    /// - Date: Jan 8, 2019
    /// - Parameters:
    ///     - background - Used to draw the background
    ///     - color - Used to draw the QRCode
    ///     - correctionLevel - The correction level used to dra the QRcode
    ///     - output - The size of the output image
    /// - Returns: A new **QRCode** UIImage.
    ///
    func qrCode(background: UIColor = .white, color: UIColor = .black, correctionLevel: QRCode.CorrectionLeveL = .m, output: CGSize = CGSize(width: 250, height: 250))-> UIImage? {
        guard
            let inputMessage = data(using: .isoLatin1),
            let qrCode = CIFilter(name: "CIQRCodeGenerator",
                                  withInputParameters: ["inputMessage": inputMessage,
                                               "inputCorrectionLevel": "M"])
            else { return nil }
        guard let image = qrCode.outputImage
            else { return nil }
        let size = image.extent.integral
        let scale = CGAffineTransform(scaleX: output.width / size.width, y: output.height / size.height)
        UIGraphicsBeginImageContextWithOptions(output, false, 0)
        defer { UIGraphicsEndImageContext() }
        guard
            let falseColor = CIFilter(name: "CIFalseColor",
                                      withInputParameters: ["inputImage" : image.transformed(by: scale),
                                                   "inputColor1": CIColor(color: background) ,
                                                   "inputColor0": CIColor(color: color)]),
            let coloredImage = falseColor.outputImage,
            let cgImage = CIContext().createCGImage(coloredImage, from: CGRect(origin: .zero, size: output))
            else { return nil }
        return UIImage(cgImage: cgImage)
    }
    // usage ot the method above
    // let link = "https://stackoverflow.com/questions/51178573/swift-image-data-from-ciimage-qr-code-how-to-render-cifilter-output?noredirect=1"
    // if let coloredQRCode = link.qrCode(color: .red, output: CGSize(width: 500, height: 500)) {
    //    coloredQRCode
    // }
}





extension String {
    static let checker = UITextChecker()
    // "football".isEnglishWord // true
    var isEnglishWord: Bool {
        return String.checker.rangeOfMisspelledWord(in: self, range: NSRange(location: 0, length: utf16.count), startingAt: 0, wrap: false, language: "en_US").location == NSNotFound
    }
}

