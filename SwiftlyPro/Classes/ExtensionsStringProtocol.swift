//
//  ExtensionsStringProtocol.swift
//  SwiftlyPro
//
//  Created by lsd on 21/11/18.
//

import Foundation

public extension StringProtocol {
    
    public var string: String {
        return String(self)
    }
    
    
    /// returns an array of all ascii values of the string
    public var ascii: [UInt32] {
        return compactMap { $0.ascii }
    }

    // subscripting the string with Int
    public subscript(offset: Int) -> Element {
        return self[index(startIndex, offsetBy: offset)]
    }
    
    public subscript(_ range: CountableRange<Int>) -> SubSequence {
        return prefix(range.lowerBound + range.count)
            .suffix(range.count)
    }
    public subscript(range: CountableClosedRange<Int>) -> SubSequence {
        return prefix(range.lowerBound + range.count)
            .suffix(range.count)
    }
    
    public subscript(range: PartialRangeThrough<Int>) -> SubSequence {
        return prefix(range.upperBound.advanced(by: 1))
    }
    public subscript(range: PartialRangeUpTo<Int>) -> SubSequence {
        return prefix(range.upperBound)
    }
    public subscript(range: PartialRangeFrom<Int>) -> SubSequence {
        return suffix(Swift.max(0, count - range.lowerBound))
    }
}

public extension StringProtocol where Index == String.Index {
    public func startIndex(of string: Self, options: String.CompareOptions = []) -> Index? {
        return range(of: string, options: options)?.lowerBound
    }
    public func endIndex(of string: Self, options: String.CompareOptions = []) -> Index? {
        return range(of: string, options: options)?.upperBound
    }
    public func startIndexes(of string: Self, options: String.CompareOptions = []) -> [Index] {
        var result: [Index] = []
        var start = startIndex
        while start < endIndex,
            let range = self[start..<endIndex].range(of: string, options: options) {
                result.append(range.lowerBound)
                start = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
    public func endIndexes(of string: Self, options: String.CompareOptions = []) -> [Index] {
        var result: [Index] = []
        var start = startIndex
        while start < endIndex,
            let range = self[start..<endIndex].range(of: string, options: options) {
                result.append(range.upperBound)
                start = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
    public func ranges(of string: Self, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var start = startIndex
        while start < endIndex,
            let range = self[start..<endIndex].range(of: string, options: options) {
                result.append(range)
                start = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }

    func encodedOffset(of element: Element) -> Int? {
        return index(of: element)?.encodedOffset
    }
    func encodedOffset(of string: Self) -> Int? {
        return range(of: string)?.lowerBound.encodedOffset
    }
}

public extension StringProtocol {
    public var isValidCPF: Bool {
        let numbers = compactMap({ Int(String($0)) })
        guard numbers.count == 11 && Set(numbers).count != 1 else { return false }
        let soma1 = 11 - ( numbers[0] * 10 +
            numbers[1] * 9 +
            numbers[2] * 8 +
            numbers[3] * 7 +
            numbers[4] * 6 +
            numbers[5] * 5 +
            numbers[6] * 4 +
            numbers[7] * 3 +
            numbers[8] * 2 ) % 11
        let dv1 = soma1 > 9 ? 0 : soma1
        let soma2 = 11 - ( numbers[0] * 11 +
            numbers[1] * 10 +
            numbers[2] * 9 +
            numbers[3] * 8 +
            numbers[4] * 7 +
            numbers[5] * 6 +
            numbers[6] * 5 +
            numbers[7] * 4 +
            numbers[8] * 3 +
            numbers[9] * 2 ) % 11
        let dv2 = soma2 > 9 ? 0 : soma2
        return dv1 == numbers[9] && dv2 == numbers[10]
    }
    
    public var isValidCNPJ: Bool {
        let numbers = compactMap({ Int(String($0)) })
        guard numbers.count == 14 && Set(numbers).count != 1 else { return false }
        let soma1 = 11 - ( numbers[11] * 2 +
            numbers[10] * 3 +
            numbers[9] * 4 +
            numbers[8] * 5 +
            numbers[7] * 6 +
            numbers[6] * 7 +
            numbers[5] * 8 +
            numbers[4] * 9 +
            numbers[3] * 2 +
            numbers[2] * 3 +
            numbers[1] * 4 +
            numbers[0] * 5 ) % 11
        let dv1 = soma1 > 9 ? 0 : soma1
        let soma2 = 11 - ( numbers[12] * 2 +
            numbers[11] * 3 +
            numbers[10] * 4 +
            numbers[9] * 5 +
            numbers[8] * 6 +
            numbers[7] * 7 +
            numbers[6] * 8 +
            numbers[5] * 9 +
            numbers[4] * 2 +
            numbers[3] * 3 +
            numbers[2] * 4 +
            numbers[1] * 5 +
            numbers[0] * 6 ) % 11
        let dv2 = soma2 > 9 ? 0 : soma2
        return dv1 == numbers[12] && dv2 == numbers[13]
    }
}
