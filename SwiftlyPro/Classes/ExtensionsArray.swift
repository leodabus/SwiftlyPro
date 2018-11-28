//
//  ExtensionsArray.swift
//  SwiftlyPro
//
//  Created by lsd on 28/11/18.
//

import Foundation
public extension Array where Element: StringProtocol, Element.Index == String.Index {
    public mutating func caseInsensitiveSortAscending() {
        sort { $0.caseInsensitiveCompare($1) == .orderedAscending
        }
    }
    public mutating func caseInsensitiveSortDescending()  {
        sort { $0.caseInsensitiveCompare($1) == .orderedDescending
        }
    }

    public func caseInsensitiveSortedAscending() -> [Element] {
        return sorted { $0.caseInsensitiveCompare($1) == .orderedAscending
        }
    }
    public func caseInsensitiveSortedDescending() -> [Element] {
        return sorted { $0.caseInsensitiveCompare($1) == .orderedDescending
        }
    }
}
