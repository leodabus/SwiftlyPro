//
//  ExtensionsUserDefaults.swift
//  SwiftlyPro
//
//  Created by lsd on 09/12/18.
//

import Foundation
extension UserDefaults {
    
    func date(forKey defaultName: String) -> Date? {
        return object(forKey: defaultName) as? Date
    }
    
    func set(_ value: UIColor, forKey defaultName: String) {
        set(NSKeyedArchiver.archivedData(withRootObject: value), forKey: defaultName)
    }
    func color(forKey defaultName: String) -> UIColor? {
        guard let data = data(forKey: defaultName) else { return nil }
        return NSKeyedUnarchiver.unarchiveObject(with: data) as? UIColor
    }
}
