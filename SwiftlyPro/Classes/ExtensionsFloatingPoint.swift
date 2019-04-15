//
//  ExtensionsFloatingPoint.swift
//  SwiftlyPro
//
//  Created by lsd on 18/11/18.
//

import Foundation
public extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
    var half:             Self { return self /   2 }
    var third:            Self { return self /   3 }
    var quater:           Self { return self /   4 }
    var fifth:            Self { return self /   5 }
    var sixth:            Self { return self /   6 }
    var seventh:          Self { return self /   7 }
    var eighth:           Self { return self /   8 }
    var nineth:           Self { return self /   9 }
    var tenth:            Self { return self /  10 }
    var hundreth:         Self { return self / 100 }
}

public extension FloatingPoint {
    var whole: Self { return modf(self).0 }
    var fraction: Self { return modf(self).1 }
}


public extension BinaryFloatingPoint {
    var int: Int {
        return Int(self)
    }
    var int8: Int8 {
        return Int8(self)
    }
    var int16: Int16 {
        return Int16(self)
    }
    var int32: Int32 {
        return Int32(self)
    }
    var int64: Int64 {
        return Int64(self)
    }
    var uint: UInt {
        return UInt(self)
    }
    var uint8: UInt8 {
        return UInt8(self)
    }
    var uint16: UInt16 {
        return UInt16(self)
    }
    var uint32: UInt32 {
        return UInt32(self)
    }
    var uint64: UInt64 {
        return UInt64(self)
    }
}


