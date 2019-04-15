//
//  ExtensionsRangeReplaceableCollection.swift
//  SwiftlyPro
//
//  Created by lsd on 29/11/18.
//

import Foundation

extension RangeReplaceableCollection where Element: Equatable {
    /// 
    @discardableResult
    mutating func appendIfNotContains(_ element: Element) -> (appended: Bool, memberAfterAppend: Element) {
        if !contains(element) {
            append(element)
            return (true, element)
        }
        return (false, element)
    }
}
extension RangeReplaceableCollection  {
    mutating func removeEvenIndexElements() {
        var bool = true
        removeAll { _ in
            defer { bool = !bool }
            return bool
        }
    }
    mutating func removeOddIndexElements() {
        var bool = false
        removeAll { _ in
            defer { bool = !bool }
            return bool
        }
    }
    func evenIndexElements() -> Self {
        var bool = true
        return filter { _ in
            defer { bool = !bool }
            return bool
        }
    }
    func oddIndexElements() -> Self {
        var bool = false
        return filter { _ in
            defer { bool = !bool }
            return bool
        }
    }
}
extension RangeReplaceableCollection where Element: Hashable {
    var orderedSet: Self {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
    mutating func removeDuplicates() {
        var set = Set<Element>()
        removeAll { !set.insert($0).inserted }
    }
}
