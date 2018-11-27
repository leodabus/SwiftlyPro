//
//  ExtensionsString.swift
//  SwiftlyPro
//
//  Created by lsd on 18/11/18.
//

import Foundation
public extension String {
    
    public var iso8601: Date? {
        return Formatter.Date.iso8601.date(from: self)   // "Mar 22, 2017, 10:22 AM"
    }

    public var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    
    public var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

public extension Substring {
    public var string: String { return String(self) }
}



