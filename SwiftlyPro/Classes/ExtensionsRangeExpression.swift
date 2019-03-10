//
//  ExtensionsRangeExpression.swift
//  Pods-SwiftlyPro_Example
//
//  Created by lsd on 24/02/19.
//

import Foundation
extension Range where Bound == Int {
    var random: Int {
        return Int.random(in: self)
    }
    func random(_ n: Int) -> [Int] {
        return (0..<n).map { _ in random }
    }
}
extension ClosedRange where Bound == Int {
    var random: Int {
        return Int.random(in: self)
    }
    func random(_ n: Int) -> [Int] {
        return (0..<n).map { _ in random }
    }
}
