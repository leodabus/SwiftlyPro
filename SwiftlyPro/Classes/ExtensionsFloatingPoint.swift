//
//  ExtensionsFloatingPoint.swift
//  SwiftlyPro
//
//  Created by lsd on 18/11/18.
//

import Foundation
public extension FloatingPoint {
    public var degreesToRadians: Self { return self * .pi / 180 }
    public var radiansToDegrees: Self { return self * 180 / .pi }
    public var half:             Self { return self /   2 }
    public var third:            Self { return self /   3 }
    public var quater:           Self { return self /   4 }
    public var fifth:            Self { return self /   5 }
    public var sixth:            Self { return self /   6 }
    public var seventh:          Self { return self /   7 }
    public var eighth:           Self { return self /   8 }
    public var nineth:           Self { return self /   9 }
    public var tenth:            Self { return self /  10 }
    public var hundreth:         Self { return self / 100 }
}

public extension FloatingPoint {
    public var whole: Self { return modf(self).0 }
    public var fraction: Self { return modf(self).1 }
}


public extension BinaryFloatingPoint {
    public var int: Int {
        return Int(self)
    }
    public var int8: Int8 {
        return Int8(self)
    }
    public var int16: Int16 {
        return Int16(self)
    }
    public var int32: Int32 {
        return Int32(self)
    }
    public var int64: Int64 {
        return Int64(self)
    }
    public var uint: UInt {
        return UInt(self)
    }
    public var uint8: UInt8 {
        return UInt8(self)
    }
    public var uint16: UInt16 {
        return UInt16(self)
    }
    public var uint32: UInt32 {
        return UInt32(self)
    }
    public var uint64: UInt64 {
        return UInt64(self)
    }
}


