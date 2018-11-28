//
//  ExtensionsBidirectionalCollection.swift
//  SwiftlyPro
//
//  Created by lsd on 28/11/18.
//

import Foundation
extension BidirectionalCollection where Element: BinaryInteger, Index == Int {
    // https://stackoverflow.com/a/52019799/2303865
    // let numbers = [1,2,3,4,10,11,15,20,21,22,23]
    // let grouped = numbers.consecutivelyGrouped  // "[[1, 2, 3, 4], [10, 11], [15], [20, 21, 22, 23]]\n"
    var consecutivelyGrouped: [[Element]] {
        return reduce(into: []) {
            $0.last?.last?.advanced(by: 1) == $1 ?
                $0[index(before: $0.endIndex)].append($1) :
                $0.append([$1])
        }
    }
}
