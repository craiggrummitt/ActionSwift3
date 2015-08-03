//
//  TextFormat.swift
//  ActionSwift
//
//  Created by Craig on 27/07/2015.
//  Copyright (c) 2015 Interactive Coconut. All rights reserved.
//
import SpriteKit
import UIKit


/** 
Set up your text formatting here, add it to your text field with the `defaultTextFormat` property.
    Get a list of iOS fonts here: http://iosfonts.com
    Leave leading as -1 and it will be automatically made the same as the font size
*/
public class TextFormat {
    var font = "ArialMT"
    var size:CGFloat = 12
    var color = UIColor.blackColor()
    var leading:CGFloat = 12
    var align:SKLabelHorizontalAlignmentMode = .Left
    
    init(font:String = "ArialMT", size:CGFloat = 12, color:UIColor = UIColor.blackColor(),leading:CGFloat = -1,align:SKLabelHorizontalAlignmentMode = .Left) {
        self.font = font
        self.size = size
        self.color = color
        if (self.leading == -1) {
            self.leading = self.size
        } else {
            self.leading = leading
        }
        self.align = align
    }
    
}