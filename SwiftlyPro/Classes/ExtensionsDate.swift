//
//  ExtensionsDate.swift
//  SwiftlyPro
//
//  Created by lsd on 18/11/18.
//

import Foundation

public extension Formatter {
    public static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        #if os(Linux)
        formatter.calendar = Calendar(identifier: .gregorian)
        #else
        formatter.calendar = Calendar(identifier: .iso8601)
        #endif
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
    static let iso8601standard: DateFormatter = {
        let formatter = DateFormatter()
        #if os(Linux)
        formatter.calendar = Calendar(identifier: .gregorian)
        #else
        formatter.calendar = Calendar(identifier: .iso8601)
        #endif
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
        return formatter
    }()
    
}

public extension Date {
    /// Returns a new Date representing the date calculated by adding an amount of a specific component using current calendar
    public func adding(_ component:  Calendar.Component, value: Int, wrappingComponents: Bool = false, calendar: Calendar = .current) -> Date? {
        return calendar.date(byAdding: component, value: value, to: self, wrappingComponents: wrappingComponents)
    }
    /// Returns a new Date representing the date calculated by setting hour, minute, and second using current calendar
    public func setting(hour:  Int, minute: Int, second: Int, matchingPolicy: Calendar.MatchingPolicy = .strict, repeatedTimePolicy: Calendar.RepeatedTimePolicy = .first, direction: Calendar.SearchDirection = .forward, calendar: Calendar = .current) -> Date? {
        return calendar.date(bySettingHour: hour, minute: minute, second: second, of: self, matchingPolicy: matchingPolicy, repeatedTimePolicy: repeatedTimePolicy, direction: direction)
    }
    
    public var noon: Date {
        return setting(hour: 12, minute: 0, second: 0)!
    }
    

    public static var yesterday: Date {
        return Date().noon.adding(.day, value: -1)!
    }
    public static var today: Date {
        return Date().noon
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

    public var iso8601: String {
        return Formatter.iso8601.string(from: self)
    }

    /// Returns all components using the current calendar time zone.
    public func dateComponents(_ components: Set<Calendar.Component>) -> DateComponents {
        return Calendar.current.dateComponents(components, from: self)
    }
    public var startOfWeek: Date {
        return Calendar.current.date(from: dateComponents([.yearForWeekOfYear, .weekOfYear]))!
    }
    public var daysOfWeek: [Date] {
        let startOfWeek = self.startOfWeek
        return (0...6).compactMap{ startOfWeek.adding(.day, value: $0) }
    }

    
    public var hour:    Int { return Calendar.current.component(.hour,   from: self) }
    public var minute:  Int { return Calendar.current.component(.minute, from: self) }
    public var second:  Int { return Calendar.current.component(.second, from: self) }
    public var year:    Int { return Calendar.current.component(.year,   from: self) }
    public var month:   Int { return Calendar.current.component(.month,  from: self) }
    public var day:     Int { return Calendar.current.component(.day,    from: self) }
    public var weekday: Int { return Calendar.current.component(.weekday,from: self) }
    
    public var nextSecond: Date {
        let date = self
        return Calendar.current.date(bySettingHour: date.hour, minute: date.minute, second: date.second + 1, of: date) ?? Date()
    }
    public var daysInMonth: Int {
        return Calendar.current.range(of: .day, in: .month, for: self)!.count
    }
    public var daysInYear: Int {
        return Calendar.current.range(of: .day, in: .year, for: self)!.count
    }
    public var nextShift: Date {
        guard let hour = dateComponents.hour, let year = dateComponents.year, let month = dateComponents.month, let day = dateComponents.day
            else { return Date() }
        switch hour {
        case 0..<6:
            return DateComponents(calendar: .current, year: year, month: month, day: day, hour: 6).date!
        case 6..<18:
            return DateComponents(calendar: .current, year: year, month: month, day: day, hour: 18).date!
        default:
            return DateComponents(calendar: .current, year: year, month: month, day: day + 1, hour: 6).date!
        }
        //        if date.hour < 6 {
        //            return  Calendar.autoupdatingCurrent.dateWithEra(1, year: date.year, month: date.month, day: date.day, hour: 6, minute: 0, second: 0, nanosecond: 0)!
        //        }
        //        if date.hour >= 6  && date.hour < 18 {
        //            return  Calendar.autoupdatingCurrent.dateWithEra(1, year: date.year, month: date.month, day: date.day, hour: 18, minute: 0, second: 0, nanosecond: 0)!
        //        }
        //        return  Calendar.autoupdatingCurrent.dateWithEra(1, year: date.year, month: date.month, day: date.day+1, hour: 6, minute: 0, second: 0, nanosecond: 0)!
    }
    public var nanosecond: Int {
        return Calendar.current.component(.nanosecond, from: self)
    }
    public var allComponents: DateComponents {
        return Calendar.current.dateComponents(in: .current, from: self)
    }
     public var dateComponents: DateComponents {
        return  Calendar.current.dateComponents([.year,.month,.day], from: self)
    }
    public  var timeComponents: DateComponents {
        return  Calendar.current.dateComponents([.hour,.minute,.second], from: self)
    }
    

    
    var monthSymbol: String {
        Formatter.custom.dateFormat = "MMMM"
        return Formatter.custom.string(from: self)
    }
    var monthShortSymbol: String {
        Formatter.custom.dateFormat = "MMM"
        return Formatter.custom.string(from: self)
    }
    var weekdaySymbol: String {
        Formatter.custom.dateFormat = "EEEE"
        return Formatter.custom.string(from: self)
    }
    var portugueseDescription: String {
        Formatter.custom.locale = Locale(identifier: "pt_BR")
        Formatter.custom.dateFormat = "EEEE, dd 'de' MMMM ' de ' yyyy"
        return Formatter.custom.string(from: self)
    }
    var precisionTime: String {
        Formatter.custom.dateFormat = "HH:mm:ss:S" // Date().second % 2 == 0 ? "HH:mm:ss:S" : "HH mm ss S"
        Formatter.custom.timeZone = .current
        
        Formatter.custom.calendar =  Calendar.autoupdatingCurrent
        Formatter.custom.locale = .current
        return Formatter.custom.string(from: self)
    }
    
}

extension Date {

    var startOfMonth: Date {
        return DateComponents(calendar: .current, year: year, month: month, day: 1).date!
    }
    var startOfNextMonth: Date {
        return DateComponents(calendar: .current, year: year, month: month+1, day: 1).date!
    }
    
    var firstDayOfMonth: Date {
        return DateComponents(calendar: .current, year: year, month: month, day: 1, hour: 12).date!
    }
    var lastDayOfMonth: Date {
        return DateComponents(calendar: .current, year: year, month: month+1, day: 0, hour: 12).date!
    }
    
    var firstDayOfPreviousMonth: Date {
        return DateComponents(calendar: .current, year: year, month: month+1, day: 1, hour: 12).date!
    }
    var lastDayOfPreviousMonth: Date {
        return DateComponents(calendar: .current, year: year, month: month+2, day: 0, hour: 12).date!
    }
    
    var firstDayOfNextMonth: Date {
        return DateComponents(calendar: .current, year: year, month: month+1, day: 1, hour: 12).date!
    }
    var lastDayOfNextMonth: Date {
        return DateComponents(calendar: .current, year: year, month: month+2, day: 0, hour: 12).date!
    }
    func date(byAddingDays days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
    enum Weekday: Int {
        case Sunday = 1, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
        var description: String {
            return Calendar.autoupdatingCurrent.weekdaySymbols[self.rawValue]
        }
    }
    func nextWeekdayDate(weekday: Weekday) -> Date {
        return  Calendar.current.nextDate(after: self, matching: DateComponents(hour: 0, weekday: weekday.rawValue), matchingPolicy: .nextTimePreservingSmallerComponents)!
        
    }
    var firstCalendarDate: Date {
        return firstDayOfMonth.date(byAddingDays: -firstDayOfMonth.weekday+1)
    }
    var calendarDates: [Date] {
        var result: [Date] = [firstCalendarDate]
        for _ in 1...41 {
            result.append(result.last!.adding(.day, value: 1)!)
        }
        return result
    }
    var isMonth: Bool {
        return  Calendar.current.date(Date(), matchesComponents: DateComponents(year: year, month: month))
    }
    
    var isBirthDay: Bool {
        return Calendar.current.date(Date(), matchesComponents: DateComponents(month: month, day: day))
    }
    var isBirthDayTomorrow: Bool {
        let date = Date()
        return Calendar.current.date(Date.tomorrow, matchesComponents: DateComponents(month: date.month, day: date.day))
    }
    var isInToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    var isInTomorrow: Bool {
        return Calendar.current.isDateInTomorrow(self)
    }
    var isInWeekend: Bool {
        return Calendar.current.isDateInWeekend(self)
    }
    var isInYesterday: Bool {
        return Calendar.current.isDateInYesterday(self)
    }
    var isSunday: Bool {
        return Calendar(identifier: .gregorian).component(.weekday, from: self) == 1
    }
    var isPast: Bool {
        return self < Date.today
    }
    var isFuture: Bool {
        return self < Date.today
    }
    func isEqualTo(_ date: Date, toGranularity: Calendar.Component) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: toGranularity)
    }
    func inSameDayAsDate(_ date: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: date)
    }
    func date(byAdding unit: Calendar.Component, value: Int) -> Date {
        return Calendar.current.date(byAdding: unit, value: value, to: self) ?? Date.distantFuture
    }
    func date(byAdding comps: DateComponents) -> Date? {
        return  Calendar.current.date(byAdding: comps, to: self)
    }
    func date(bySettingHour hour: Int, minute: Int, second: Int)-> Date? {
        return  Calendar.current.date(bySettingHour: hour, minute: minute, second: second, of: self)
    }
    func date(bySetting component: Calendar.Component, value: Int) -> Date? {
        return  Calendar.current.date(bySetting: component, value: value, of: self)
    }
    
}


extension Formatter {
    static let custom = DateFormatter()
}




