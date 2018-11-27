//
//  ExtensionsData.swift
//  SwiftlyPro
//
//  Created by lsd on 19/11/18.
//

import Foundation
public extension Data {
    public var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    public var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}
