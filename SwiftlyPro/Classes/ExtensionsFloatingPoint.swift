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
