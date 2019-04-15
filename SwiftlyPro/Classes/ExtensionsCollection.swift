//
//  ExtensionsCollection.swift
//  SwiftlyPro
//
//  Created by lsd on 18/11/18.
//

import Foundation

public extension Collection {
    //    https://stackoverflow.com/a/47544741/2303865
    //
    //    let objects: [Any] = [1,[2,3],"a",["b",["c","d"]]]
    //    let joined = objects.joined()   // [1, 2, 3, "a", "b", "c", "d"]
    //
    //    let integers = objects.flatMapped(with: Int.self)  // [1, 2, 3]
    //    // setting the type explicitly
    //    let integers2: [Int] = objects.flatMapped()        // [1, 2, 3]
    //    // or casting
    //    let strings = objects.flatMapped() as [String]     // ["a", "b", "c", "d"]
    func joined() -> [Any] {
        return flatMap { ($0 as? [Any])?.joined() ?? [$0] }
    }
    func flatMapped<T>(with type: T.Type? = nil) -> [T] {
        return joined().compactMap { $0 as? T }
    }
   
    var pairs: [SubSequence] {
        var startIndex = self.startIndex
        let count = self.count
        let n = count/2 + (count % 2 == 0 ? 0 : 1)
        return (0..<n).map { _ in
            let endIndex = index(startIndex, offsetBy: 2, limitedBy: self.endIndex) ?? self.endIndex
            defer { startIndex = endIndex }
            return self[startIndex..<endIndex]
        }
    }
    
}

public extension Collection where Self: BidirectionalCollection  {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    subscript(safe offset: Int) -> Element? {
        guard let index = self.index(startIndex,
                                    offsetBy: offset,
                                    limitedBy: self.index(before: endIndex))
        else { return nil }
        return  self[index]
    }
}


public extension Collection where Element: Numeric {
    /// Returns the total sum of all elements in the array
    var total: Element { return reduce(0, +) }
    var squared: [Element] { return map({ $0 * $0 }) }
    var cubed:   [Element] { return map({ $0 * $0 * $0 }) }

}

public extension Collection where Element: BinaryInteger {
    /// Returns the average of all elements in the array
    var average: Double {
        return isEmpty ? 0 : Double(Int(total)) / Double(count)
    }
}

public extension Collection where Element: BinaryFloatingPoint {
    /// Returns the average of all elements in the array
    var average: Element {
        return isEmpty ? 0 : total / Element(count)
    }
}
public extension Collection where Element == Decimal {
    var average: Decimal {
        return isEmpty ? 0 : total / Decimal(count)
    }
}


// Collection of Bytes
public extension Collection where Element == UInt8 {
    var array: [UInt8] { return Array(self) }
    var data: Data { return Data(self) }
}


// Collection of Equatable Elements
public extension Collection where Element: Equatable {
    var grouped: [[Element]] {
        return reduce(into: []) {
            $0.last?.last == $1 ?
            $0[$0.index(before: $0.endIndex)].append($1) :
            $0.append([$1])
        }
    }
    func indices(of element: Element) -> [Index] {
        return indices.filter { self[$0] == element }
    }
    func indices(where isIncluded: (Element) -> Bool) -> [Index] {
        return indices.filter { isIncluded(self[$0]) }
    }
}


public extension Collection where Element: StringProtocol {
    func caseInsensitiveSorted(_ result: ComparisonResult) -> [Element] {
        return sorted { $0.caseInsensitiveCompare($1) == result }
    }
    
    func localizedSorted(_ result: ComparisonResult) -> [Element] {
        return sorted { $0.localizedCompare($1) == result }
    }
    func localizedCaseInsensitiveSorted(_ result: ComparisonResult) -> [Element] {
        return sorted { $0.localizedCaseInsensitiveCompare($1) == result }
    }
    
}

extension Collection where Element == Bool {
    var allTrue: Bool { return allSatisfy{ $0 } }
    var allFalse: Bool { return allSatisfy{ !$0 } }
}
