//
//  ExtensionsStringProtocol.swift
//  SwiftlyPro
//
//  Created by lsd on 21/11/18.
//

import Foundation
public extension StringProtocol {
  
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
    
    public var range: Range<Index> {
        return startIndex..<endIndex
    }
    public var nsRange: NSRange {
        return NSRange(range, in: self)
    }

    func index(of string: Self, options: String.CompareOptions = []) -> Index? {
        return range(of: string, options: options)?.lowerBound
    }
    
    public func endIndex(of string: Self, options: String.CompareOptions = []) -> Index? {
        return range(of: string, options: options)?.upperBound
    }
    
    public func indexes(of string: Self, options: String.CompareOptions = []) -> [Index] {
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
    
    public func nsRange(of string: Self, options: String.CompareOptions = [], range: Range<Index>? = nil, locale: Locale? = nil) -> NSRange? {
        guard let range = self.range(of: string, options: options, range: range ?? startIndex..<endIndex, locale: locale ?? .current) else { return nil }
        return NSRange(range, in: self)
    }
    
    public func nsRanges(of string: Self, options: String.CompareOptions = [], range: Range<Index>? = nil, locale: Locale? = nil) -> [NSRange] {
        var start = range?.lowerBound ?? startIndex
        let end = range?.upperBound ?? endIndex
        var ranges: [NSRange] = []
        while start < end, let range = self.range(of: string, options: options, range: start..<end, locale: locale ?? .current) {
            ranges.append(NSRange(range, in: self))
            start = range.upperBound
        }
        return ranges
    }
    
    func nsRange(from range: Range<Index>) -> NSRange {
        return NSRange(range, in: self)
    }

    public func encodedOffset(of element: Element) -> Int? {
        return index(of: element)?.encodedOffset
    }
    public func encodedOffset(of string: Self) -> Int? {
        return range(of: string)?.lowerBound.encodedOffset
    }

    //    Finds a text between two strings and returns it
    //    let text = "word(abc)"
    //    if let found = text.getString(between: "(", and: ")") {
    //        print("found:", found)  // "found: abc"
    //    }
    func substring(upTo string: Self, options: String.CompareOptions = [], range: Range<Index>? = nil, locale: Locale? = nil) -> SubSequence? {
        guard  let lowerBound = self.range(of: string, options: options, locale: locale)?.lowerBound
        else { return nil }
        return self[..<lowerBound]    // "abc"
    }
    func substring(between start: Self, and end: Self, options: String.CompareOptions = [], locale: Locale? = nil) -> SubSequence? {
        guard
            let lowerRange = self.range(of: start, options: options, locale: locale),
            let upperRange  = self[lowerRange.upperBound..<endIndex].range(of: end, options: options, locale: locale)
            else {
                return nil
        }
        return self[lowerRange.upperBound..<upperRange.lowerBound]    // "abc"
    }

    var lines: [SubSequence] {
        return substrings(separated: .byLines)
    }
    var words: [SubSequence] {
        return substrings(separated: .byWords)
    }
    var sentences: [SubSequence] {
        return substrings(separated: .bySentences)
    }
    var paragraphs: [SubSequence] {
        return substrings(separated: .byParagraphs)
    }
    func substrings(separated options: String.EnumerationOptions)-> [SubSequence] {
        var substrings: [SubSequence] = []
        enumerateSubstrings(in: startIndex..., options: options) {
            _, range, _, _ in substrings.append(self[range])
        }
        return substrings
    }
    func ranges(separated options: String.EnumerationOptions)-> [Range<Index>] {
        var ranges: [Range<Index>] = []
        enumerateSubstrings(in: startIndex..., options: options) {
            _, range, _, _ in ranges.append(range)
        }
        return ranges
    }
    
    
    var firstLineRange: Range<Index> {
        return lineRange(for: ..<startIndex)
    }
    var lastLineRange: Range<Index> {
        return lineRange(for: endIndex...)
    }
    var firstLineNSRange: NSRange {
        return NSRange(firstLineRange, in: self)
    }
    var lastLineNSRange: NSRange {
        return NSRange(lastLineRange, in: self)
    }
    var firstLine: SubSequence {
        return  self[firstLineRange]
    }
    var lastLine: SubSequence {
        return  self[lastLineRange]
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
extension StringProtocol {
    var hexa2Bytes: [UInt8] {
        let hexa = Array(self)
        return stride(from: 0, to: count, by: 2).compactMap { UInt8(String(hexa[$0..<$0.advanced(by: 2)]), radix: 16) }
    }
}

extension StringProtocol where Self: RangeReplaceableCollection {
    mutating func insert(separator: Self, every n: Int) {
        for index in indices.reversed() where index != startIndex &&
            distance(from: startIndex, to: index) % n == 0 {
                insert(contentsOf: separator, at: index)
        }
    }
    
    func inserting(separator: Self, every n: Int) -> Self {
        var string = self
        string.insert(separator: separator, every: n)
        return string
    }
}
extension StringProtocol where Index == String.Index {
    func distance(to element: Element) -> Int? {
        guard let index = index(of: element) else { return nil }
        return distance(from: startIndex, to: index)
    }
    func distance(to string: Self, options: String.CompareOptions = []) -> Int? {
        return range(of: string, options: options)?.lowerBound.encodedOffset
    }
}
