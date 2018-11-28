//
//  ExtensionsBidirectionalCollection.swift
//  SwiftlyPro
//
//  Created by lsd on 28/11/18.
//

import Foundation
extension BidirectionalCollection where Element: BinaryInteger, Index == Int {
    var consecutivelyGrouped: [[Element]] {
        return reduce(into: []) {
            $0.last?.last?.advanced(by: 1) == $1 ?
                $0[index(before: $0.endIndex)].append($1) :
                $0.append([$1])
        }
    }
}
