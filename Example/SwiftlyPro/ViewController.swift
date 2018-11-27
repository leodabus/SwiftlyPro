//
//  ViewController.swift
//  SwiftlyPro
//
//  Created by leodabus on 11/18/2018.
//  Copyright (c) 2018 leodabus. All rights reserved.
//

import SwiftlyPro
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let date = Date().iso8601
        print(date)
        let test = "Hello USA 🇺🇸!!! Hello Brazil 🇧🇷!!!"
        print(test[safe: 10] ?? "nil")   // "🇺🇸"
        print(test[11])   // "!"
        print(test[10...])   // "🇺🇸!!! Hello Brazil 🇧🇷!!!"
        print(test[10..<12])   // "🇺🇸!"
        print(test[10...12])   // "🇺🇸!!"
        print(test[...10])   // "Hello USA 🇺🇸"
        print(test[..<10])   // "Hello USA "
        print(test.first ?? "nil")  // "H"
        print(test.last ?? "nil")    // "!"
        
        // Subscripting the Substring
        print(test[...][...3])  // "Hell"
        
        // Note that they all return a Substring of the original String.
        // To create a new String you need to add .string as follow
        print(test[10...].string)  // "🇺🇸!!! Hello Brazil 🇧🇷!!!"
        let arr = [1,2,3]
        print(arr[safe: 3] ?? "nil")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

