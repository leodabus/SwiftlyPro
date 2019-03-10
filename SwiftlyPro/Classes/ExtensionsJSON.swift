//
//  ExtensionsJSON.swift
//  SwiftlyPro
//
//  Created by lsd on 29/11/18.
//

import Foundation

public extension JSONDecoder.DateDecodingStrategy {
    public static let customISO8601 = custom { decoder throws -> Date in
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        if let date = Formatter.Date.iso8601.date(from: string) ?? Formatter.Date.iso8601standard.date(from: string) {
            return date
        }
        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date: \(string)")
    }
}
public extension JSONEncoder.DateEncodingStrategy {
    public static let customISO8601 = custom { date, encoder throws in
        var container = encoder.singleValueContainer()
        try container.encode(Formatter.Date.iso8601.string(from: date))
    }
}
