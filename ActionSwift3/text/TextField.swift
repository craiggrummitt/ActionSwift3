//
//  TextField.swift
//  ActionSwift
//
//  Created by Craig on 24/07/2015.
//  Copyright (c) 2015 Interactive Coconut. All rights reserved.
//

import SpriteKit

/** Set up your text field here. Beyond basic formatting (i.e. textColor), apply formatting using the `defaultTextFormat` property, passing in a TextFormat object. You also have background color, border color properties.
*/

public class TextField: InteractiveObject {
    internal var textFieldNode = SKMultilineLabel(text: "", labelWidth: 100, pos: CGPoint(x: 0, y: 0))
    public var _textFormat:TextFormat = TextFormat()
    
    private var isDirty:Boolean = false

    override public init() {
        super.init()
        textFieldNode.dontUpdate = true
        self.node.addChild(textFieldNode)
        textFieldNode.position.x = 0
        textFieldNode.position.y = Stage.size.height
       textFieldNode.owner = self
    }
    public var defaultTextFormat:TextFormat {
        get {return _textFormat}
        set(newValue) {
            _textFormat = newValue
            textFieldNode.alignment = newValue.align
            textFieldNode.fontName = newValue.font
            textFieldNode.fontSize = newValue.size
            textFieldNode.fontColor = newValue.color
            textFieldNode.leading = newValue.leading
            isDirty = true
        }
    }
    public var textColor:UIColor {
        get {return textFieldNode.fontColor}
        set(newValue) {
            defaultTextFormat.color = newValue
            textFieldNode.fontColor = newValue
            isDirty = true
        }
    }
    public var text:String {
        get {return textFieldNode.text}
        set(newValue) {
            textFieldNode.text = newValue
            isDirty = true
        }
    }
    public var background:Bool {
        get {return textFieldNode.shouldShowBackground}
        set(newValue) {
            textFieldNode.shouldShowBackground = newValue
            isDirty = true
        }
    }
    /** Background color - will only be active if `background` is set to true */
    public var backgroundColor:UIColor {
        get {return textFieldNode.backgroundColor}
        set(newValue) {
            textFieldNode.backgroundColor = newValue
            isDirty = true
        }
    }
    public var border:Bool {
        get {return textFieldNode.shouldShowBorder}
        set(newValue) {
            textFieldNode.shouldShowBorder = newValue
            isDirty = true
        }
    }
    /** Border color - will only be active if `background` is set to true */
    public var borderColor:UIColor {
        get {return textFieldNode.borderColor}
        set(newValue) {
            textFieldNode.borderColor = newValue
            isDirty = true
        }
    }
    override internal func update(currentTime:CFTimeInterval) {
        super.update(currentTime)
        if (isDirty) {
            print("Updating textField \(width), \(height)")
            textFieldNode.update(forceUpdate:true)
            textFieldNode.position.x = (width / 2)
            isDirty = false
        }
    }

    public var length:Int {
        return text.characters.count
    }
    override public var height:CGFloat {
        return textFieldNode.height
    }
    override public var width:CGFloat {
        get {return textFieldNode.width}
        set(newValue) {
            textFieldNode.labelWidth = newValue
            isDirty = true
        }
    }
}
