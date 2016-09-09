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
open class TextFormat:Object {
    open var font = "ArialMT"
    open var size:CGFloat = 12
    open var color = UIColor.black
    open var leading:CGFloat = 12
    open var align:SKLabelHorizontalAlignmentMode = .left
    
    public init(font:String = "ArialMT", size:CGFloat = 12, color:UIColor = UIColor.black,leading:CGFloat = -1,align:SKLabelHorizontalAlignmentMode = .left) {
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
