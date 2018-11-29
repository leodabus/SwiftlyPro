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
    public func joined() -> [Any] {
        return flatMap { ($0 as? [Any])?.joined() ?? [$0] }
    }
    public func flatMapped<T>(with type: T.Type? = nil) -> [T] {
        return joined().compactMap { $0 as? T }
    }
}

public extension Collection where Self: BidirectionalCollection  {
    public subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    public subscript(safe index: Int) -> Element? {
        guard let index = self.index(startIndex,
                                    offsetBy: index,
                                    limitedBy: self.index(before: endIndex))
        else { return nil }
        return  self[index]
    }
}


public extension Collection where Element: Numeric {
    /// Returns the total sum of all elements in the array
    public var total: Element { return reduce(0, +) }
    public var squared: [Element] { return map({ $0 * $0 }) }
    public var cubed:   [Element] { return map({ $0 * $0 * $0 }) }

}

public extension Collection where Element: BinaryInteger {
    /// Returns the average of all elements in the array
    public var average: Double {
        return isEmpty ? 0 : Double(Int(total)) / Double(count)
    }
}

public extension Collection where Element: BinaryFloatingPoint {
    /// Returns the average of all elements in the array
    public var average: Element {
        return isEmpty ? 0 : total / Element(count)
    }
}
public extension Collection where Element == Decimal {
    public var average: Decimal {
        return isEmpty ? 0 : total / Decimal(count)
    }
}


// Collection of Bytes
public extension Collection where Element == UInt8 {
    public var array: [UInt8] { return Array(self) }
    public var data: Data { return Data(self) }
}


// Collection of Equatable Elements
public extension Collection where Element: Equatable {
    public var grouped: [[Element]] {
        return reduce(into: []) {
            $0.last?.last == $1 ?
            $0[$0.index(before: $0.endIndex)].append($1) :
            $0.append([$1])
        }
    }
}

// Collection of Hashable Elements
public extension Collection where Element: Hashable {
    // counts the occurrences of an element in a collection
    public var frequency: [Element: Int] {
        return reduce(into: [:]) { $0[$1, default: 0] += 1 }
    }
    // returns the number of occurrences of an element in a collection
    public func frequency(of element: Element) -> Int {
        return frequency[element] ?? 0
    }
    
    // returns the maximum value in a collection
    public var maxValue: (Element, Int)? {
        return frequency.max(by: { $0.value < $1.value })
    }
    // returns the minimum value in a collection
    public var minValue: (Element, Int)? {
        return frequency.min(by: { $0.value < $1.value })
    }

    
}
public extension Collection where Element: Hashable, Element: Comparable {
    // returns the maximum key in a collection
    public var maxKey: (Element, Int)? {
        return frequency.max(by: { $0.key < $1.key })
    }
    // returns the minimum key in a collection
    public var minKey: (Element, Int)? {
        return frequency.min(by: { $0.key < $1.key })
    }
}

