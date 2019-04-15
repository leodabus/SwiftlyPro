//
//  ExtensionsNumeric.swift
//  SwiftlyPro
//
//  Created by lsd on 21/11/18.
//

import Foundation
public extension Numeric {
    
    mutating func square() {
        self = self * self
    }
    
    mutating func cube() {
        self = self * self * self
    }
    
    var squared: Self {
        return self * self
    }

    var cubic: Self {
        return self * self * self
    }

    
    var data: Data {
        var source = self
        return Data(bytes: &source, count: MemoryLayout<Self>.size)
    }
}
