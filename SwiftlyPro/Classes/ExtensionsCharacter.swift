//
//  ExtensionsCharacter.swift
//  SwiftlyPro
//
//  Created by lsd on 21/11/18.
//

import Foundation
public extension Character {
    // this is already implemented in Swift 5
    var isASCII: Bool {
        return asciiValue != nil
    }
    // this is already implemented in Swift 5
    var asciiValue: UInt8? {
        guard self != "\r\n" else { return 10 }
        return unicodeScalars.index(after: unicodeScalars.startIndex) != unicodeScalars.endIndex || unicodeScalars.first!.value >= 128 ? nil : UInt8(unicodeScalars.first!.value)
    }
}
