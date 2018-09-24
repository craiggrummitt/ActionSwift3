//
//  UIColor.swift
//  ActionSwift
//
//  Created by Craig on 5/08/2015.
//  Copyright (c) 2015 Interactive Coconut. All rights reserved.
//

import Foundation
import UIKit

/**
Add hex initializer, eg `UIColor(hex:"#FFFFFF")
*/
extension UIColor {
    /** initialize with hex string.
Use format eg. "#FFFFFF"
*/
    convenience public init(hex: String) {
        var hex = hex
        var alpha: Float = 100
        let hexLength = hex.count
        if !(hexLength == 7 || hexLength == 9) {
            // A hex must be either 7 or 9 characters (#GGRRBBAA)
            print("improper call to 'colorFromHex', hex length must be 7 or 9 chars (#GGRRBBAA). You've called \(hex)")
            self.init(white: 0, alpha: 1)
            return
        }
        
        if hexLength == 9 {
            let temp = hex[7...8]
            alpha = temp.floatValue
            hex = hex[0...6]
        }
        
        // Establishing the rgb color
        var rgb: UInt32 = 0
        let s: Scanner = Scanner(string: hex)
        // Setting the scan location to ignore the leading `#`
        s.scanLocation = 1
        // Scanning the int into the rgb colors
        s.scanHexInt32(&rgb)
        
        // Creating the UIColor from hex int
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha / 100)
        )
    }
}
