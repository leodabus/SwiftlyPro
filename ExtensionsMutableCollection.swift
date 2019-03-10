//
//  ExtensionsMutableCollection.swift
//  Pods-SwiftlyPro_Example
//
//  Created by lsd on 22/02/19.
//

import Foundation
public extension MutableCollection where Element: StringProtocol, Element.Index == String.Index, Self: RandomAccessCollection {
    
    public mutating func caseInsensitiveSort(by predicate: (Self.Element, Self.Element) throws -> Bool) rethrows  {
        let result: ComparisonResult
        if try predicate("a","b") {
            print("ascending")
            result = .orderedAscending
        } else {
            print("descending")
            result = .orderedDescending
        }
        sort { $0.caseInsensitiveCompare($1) == result }
    }
    
    public mutating func caseInsensitiveSort(_ result: ComparisonResult) {
        sort { $0.caseInsensitiveCompare($1) == result }
    }
    public mutating func caseInsensitiveSort() {
        sort(by: <)
    }
    
    public mutating func localizedSort(_ result: ComparisonResult) {
        sort { $0.localizedCompare($1) == result }
    }
}
