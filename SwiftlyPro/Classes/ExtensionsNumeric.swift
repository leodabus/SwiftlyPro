//
//  ExtensionsNumeric.swift
//  SwiftlyPro
//
//  Created by lsd on 21/11/18.
//

import Foundation
public extension Numeric {
    
    public mutating func square() {
        self = self * self
    }
    
    public mutating func cube() {
        self = self * self * self
    }
    
    public var squared: Self {
        return self * self
    }

    public var cubic: Self {
        return self * self * self
    }

    
    public var data: Data {
        var source = self
        return Data(bytes: &source, count: MemoryLayout<Self>.size)
    }
}
