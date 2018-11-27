//
//  ExtensionsCharacter.swift
//  SwiftlyPro
//
//  Created by lsd on 21/11/18.
//

import Foundation
public extension Character {
    public var string: String {
        return String(self)
    }
    public var isAscii: Bool {
        return unicodeScalars.first?.isASCII == true
    }
    public var ascii: UInt32? {
        return isAscii ? unicodeScalars.first?.value : nil
    }
}
