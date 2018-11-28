//
//  ExtensionsBinaryInteger.swift
//  SwiftlyPro
//
//  Created by lsd on 18/11/18.
//

import Foundation
public extension BinaryInteger {
    public var degreesToRadians: CGFloat {
        return CGFloat(Int(self)) * .pi / 180
    }
 
    // implemented using this anser as reference from Marting R on SO
    // https://stackoverflow.com/a/29468466/2303865
    public var digitsSum: Self {
        return sequence(state: self) { digit in
            defer { digit /= 10 }
            return digit > 0 ? digit % 10 : nil
            }.reduce(0, +)
    }
    
}
