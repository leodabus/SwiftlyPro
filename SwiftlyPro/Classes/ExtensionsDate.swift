//
//  ExtensionsDate.swift
//  SwiftlyPro
//
//  Created by lsd on 18/11/18.
//

import Foundation

public extension Date {
    /// Returns a new Date representing the date calculated by adding an amount of a specific component using current calendar
    public func adding(_ component:  Calendar.Component, value: Int, wrappingComponents: Bool = false) -> Date? {
        return Calendar.current.date(byAdding: component, value: value, to: self, wrappingComponents: wrappingComponents)
    }
    /// Returns a new Date representing the date calculated by setting hour, minute, and second using current calendar
    public func setting(hour:  Int, minute: Int, second: Int, matchingPolicy: Calendar.MatchingPolicy = .strict, repeatedTimePolicy: Calendar.RepeatedTimePolicy = .first, direction: Calendar.SearchDirection = .forward) -> Date? {
        return Calendar.current.date(bySettingHour: hour, minute: minute, second: second, of: self, matchingPolicy: matchingPolicy, repeatedTimePolicy: repeatedTimePolicy, direction: direction)
    }
    
    public var noon: Date {
        return setting(hour: 12, minute: 0, second: 0)!
    }
    
    public static var yesterday: Date {
        return Date().noon.adding(.day, value: -1)!
    }
    public static var tomorrow: Date {
        return Date().noon.adding(.day, value: 1)!
    }
    
    
    public var dayBefore: Date {
        return noon.adding(.day, value: -1)!
    }
    public var dayAfter: Date {
        return noon.adding(.day, value: 1)!
    }
}
public extension Formatter {
    public struct Date {
        public static let iso8601: DateFormatter = {
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
            return formatter
        }()
    }
}
public extension Date {
    public var iso8601: String {
        return Formatter.Date.iso8601.string(from: self)
    }
}


public extension Date {
    /// Returns all components using the current calendar time zone.
    func dateComponents(_ components: Set<Calendar.Component>) -> DateComponents {
        return Calendar.current.dateComponents(components, from: self)
    }
    public var startOfWeek: Date {
        return Calendar.current.date(from: dateComponents([.yearForWeekOfYear, .weekOfYear]))!
    }
    public var daysOfWeek: [Date] {
        let startOfWeek = self.startOfWeek
        return (0...6).compactMap{ startOfWeek.adding(.day, value: $0) }
    }
}



