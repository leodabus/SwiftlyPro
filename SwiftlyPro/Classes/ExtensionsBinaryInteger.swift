//
//  ExtensionsBinaryInteger.swift
//  SwiftlyPro
//
//  Created by lsd on 18/11/18.
//

import Foundation
public extension BinaryInteger {
    public var degreesToRadians: CGFloat { return CGFloat(Int(self)) * .pi / 180 }
}
