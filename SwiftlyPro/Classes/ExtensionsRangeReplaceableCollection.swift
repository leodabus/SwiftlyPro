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
