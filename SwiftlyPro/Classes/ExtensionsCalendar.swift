//
//  ExtensionsCalendar.swift
//  SwiftlyPro
//
//  Created by lsd on 01/12/18.
//

import Foundation

public extension Calendar {
    public static let buddhist = Calendar(identifier: .buddhist)
    public static let chinese = Calendar(identifier: .chinese)
    public static let coptic = Calendar(identifier: .coptic)
    public static let ethiopicAmeteAlem = Calendar(identifier: .ethiopicAmeteAlem)
    public static let ethiopicAmeteMihret = Calendar(identifier: .ethiopicAmeteMihret)
    public static let gregorian = Calendar(identifier: .gregorian)
    public static let hebrew = Calendar(identifier: .hebrew)
    public static let indian = Calendar(identifier: .indian)
    public static let islamic = Calendar(identifier: .islamic)
    public static let islamicCivil = Calendar(identifier: .islamicCivil)
    public static let islamicTabular = Calendar(identifier: .islamicTabular)
    public static let islamicUmmAlQura = Calendar(identifier: .islamicUmmAlQura)
    public static let iso8601 = Calendar(identifier: .iso8601)
    public static let japanese = Calendar(identifier: .japanese)
    public static let persian = Calendar(identifier: .persian)
    public static let republicOfChina = Calendar(identifier: .republicOfChina)
}
public extension Locale {
    public static let posix = Locale(identifier: "en_US_POSIX")
}
