//
//  DisplayObject.swift
//  ActionSwiftSK
//
//  Created by Craig on 5/05/2015.
//  Copyright (c) 2015 Interactive Coconut. All rights reserved.
//

import SpriteKit
enum DisplayEvent:String {
    case Added = "Added"
    case Removed = "Removed"
}
public class DisplayObject: EventDispatcher, Equatable, StageSceneProtocol {
    var parent:DisplayObjectContainer?
    var objectName:String = ""
    internal var spriteNode  = SpriteNode()
    internal var node = SKNode()
    
    override init() {
        super.init()
        node.addChild(spriteNode)
        spriteNode.owner = self
        spriteNode.userInteractionEnabled = true

    }
    public var alpha:CGFloat {
        get {return node.alpha}
        set(newValue) {node.alpha = newValue}
    }
    public var height:CGFloat {
        return node.frame.height
    }
    public var width:CGFloat {
        return node.frame.width
    }
    public var rotation:CGFloat {
        get {return -node.zRotation * 180 / CGFloat(M_PI)}
        set(newValue) {node.zRotation = -newValue * CGFloat(M_PI) / 180}
    }
    public var scaleX:CGFloat {
        get {return node.xScale}
        set(newValue) {node.xScale = newValue}
    }
    public var scaleY:CGFloat {
        get {return node.yScale}
        set(newValue) {node.yScale = newValue}
    }
    public var x:CGFloat {
        get {return node.position.x}
        set (newValue) {node.position.x = newValue}
    }
    public var y:CGFloat {
        get {return node.position.y}
        set (newValue) {node.position.y = newValue}
    }
    internal func update(currentTime:CFTimeInterval) {
        
    }
}
