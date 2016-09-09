//
//  SKMultilineLabel.swift
//  GrabbleWords
//
//  Created by Craig on 10/04/2015.
//  Copyright (c) 2015 Interactive Coconut. All rights reserved.
//
/*   USE:

(most component parameters have defaults)

```
let multiLabel = SKMultilineLabel(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", labelWidth: 250, pos: CGPoint(x: size.width / 2, y: size.height / 2))
self.addChild(multiLabel)
```

*/

import SpriteKit

open class SKMultilineLabel: SKNode {
    weak var owner:DisplayObject? {
        didSet {
            for label in labels {
                label.owner = owner
                label.isUserInteractionEnabled = true
            }
        }
    }
    //props
    var labelWidth:CGFloat {didSet {update()}}
    var labelHeight:CGFloat = 0
    var text:String {didSet {update()}}
    var fontName:String {didSet {update()}}
    var fontSize:CGFloat {didSet {update()}}
    /**refers to the centre(x) top(y) of the label*/
    var pos:CGPoint {didSet {update()}}
    var fontColor:UIColor {didSet {update()}}
    var leading:CGFloat {didSet {update()}}
    var alignment:SKLabelHorizontalAlignmentMode {didSet {update()}}
    var dontUpdate = false
    var shouldShowBorder:Bool = false {didSet {update()}}
    var shouldShowBackground:Bool = false {didSet {update()}}
    var borderColor:UIColor = UIColor.white
    var backgroundColor:UIColor = UIColor.white
    //display objects
    var rect:SKShapeNode?
    var labels:[LabelNode] = []
    var lineCount = 0
    
    init(text:String, labelWidth:CGFloat, pos:CGPoint, fontName:String="ChalkboardSE-Regular",fontSize:CGFloat=10,fontColor:UIColor=UIColor.black,leading:CGFloat=10, alignment:SKLabelHorizontalAlignmentMode = .center, shouldShowBorder:Bool = false,shouldShowBackground:Bool = false,borderColor:UIColor = UIColor.white,backgroundColor:UIColor = UIColor.white)
    {
        self.text = text
        self.labelWidth = labelWidth
        self.pos = pos
        self.fontName = fontName
        self.fontSize = fontSize
        self.fontColor = fontColor
        self.leading = leading
        self.shouldShowBorder = shouldShowBorder
        self.shouldShowBackground = shouldShowBackground
        self.borderColor = borderColor
        self.backgroundColor = backgroundColor
        self.alignment = alignment

        super.init()

        self.update(forceUpdate: true)
    }
    //if you want to change properties without updating the text field,
    //  set dontUpdate to true and call the update method manually, passing forceUpdate as true.
    func update(forceUpdate:Bool = false) {
        if (dontUpdate && !forceUpdate) {return}
        if (labels.count>0) {
            for label in labels {
                label.removeFromParent()
            }
            labels = []
        }
        let separators = CharacterSet.whitespacesAndNewlines
        let words = text.components(separatedBy: separators)
        
        var finalLine = false
        var wordCount = -1
        lineCount = 0
        while (!finalLine) {
            lineCount += 1
            var lineLength = CGFloat(0)
            var lineString = ""
            var lineStringBeforeAddingWord = ""
            
            // creation of the SKLabelNode itself
            let label = LabelNode(fontNamed: fontName)
            if let owner = owner {
                label.owner = owner
                label.isUserInteractionEnabled = true
            }
            
            // name each label node so you can animate it if u wish
            label.name = "line\(lineCount)"
            label.horizontalAlignmentMode = alignment
            label.fontSize = fontSize
            label.fontColor = fontColor
            
            while lineLength < CGFloat(labelWidth)
            {
                wordCount += 1
                if wordCount > words.count-1
                {
                    //label.text = "\(lineString) \(words[wordCount])"
                    finalLine = true
                    break
                }
                else
                {
                    lineStringBeforeAddingWord = lineString
                    lineString = "\(lineString) \(words[wordCount])"
                    label.text = lineString
                    lineLength = label.frame.width
                }
            }
            if lineLength > 0 {
                wordCount -= 1
                if (!finalLine) {
                    lineString = lineStringBeforeAddingWord
                }
                label.text = lineString
                var linePos = pos
                if (alignment == .left) {
                    linePos.x -= CGFloat(labelWidth / 2)
                } else if (alignment == .right) {
                    linePos.x += CGFloat(labelWidth / 2)
                }
                linePos.y += -leading * CGFloat(lineCount)
                label.position = CGPoint( x: linePos.x , y: linePos.y )
                self.addChild(label)
                labels.append(label)
            }
            
        }
        labelHeight = CGFloat(lineCount) * leading
        showBorder()
    }
    func showBorder() {
        if (!shouldShowBorder && !shouldShowBackground) {return}
        if let rect = self.rect {
            self.removeChildren(in: [rect])
        }
        self.rect = SKShapeNode(rectOf: CGSize(width: labelWidth, height: labelHeight))
        if let rect = self.rect {
            if (shouldShowBackground) {
                rect.fillColor = backgroundColor
            }
            if (shouldShowBorder) {
                rect.strokeColor = borderColor
                rect.lineWidth = 1
            }
            rect.position = CGPoint(x: pos.x, y: pos.y - (CGFloat(labelHeight) / 2.0))
            
            self.insertChild(rect, at: 0)
            rect.zPosition = -1
        }
        
    }
    var width:CGFloat {
        return CGFloat(labelWidth)
    }
    var height:CGFloat {
        get {
            if labels.count==0 {
                return 0
            } else {
                return (CGFloat(labels.count * Int(leading)))
            }
        }
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
