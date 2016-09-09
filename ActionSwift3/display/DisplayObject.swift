//
//  DisplayObject.swift
//  ActionSwiftSK
//
//  Created by Craig on 5/05/2015.
//  Copyright (c) 2015 Interactive Coconut. All rights reserved.
//

import SpriteKit
/**
The base class for all display objects. Contains basic properties such as `width`, `height`, `scaleX`, `scaleY`, `x` and `y`.
*/
open class DisplayObject: EventDispatcher, StageSceneProtocol {
    open weak var parent:DisplayObjectContainer?
    open var name:String = ""
    open weak var stage:Stage?
    
    internal var node = SKNode()
    
    override public init() {
        super.init()

    }
    open var alpha:CGFloat {
        get {return node.alpha}
        set(newValue) {node.alpha = newValue}
    }
    open var height:CGFloat {
        return node.frame.height
    }
    open var width:CGFloat {
        return node.frame.width
    }
    open var rotation:CGFloat {
        get {return -node.zRotation * 180 / CGFloat(M_PI)}
        set(newValue) {node.zRotation = -newValue * CGFloat(M_PI) / 180}
    }
    open var scaleX:CGFloat {
        get {return node.xScale}
        set(newValue) {node.xScale = newValue}
    }
    open var scaleY:CGFloat {
        get {return node.yScale}
        set(newValue) {node.yScale = newValue}
    }
    open var x:CGFloat {
        get {return node.position.x}
        set (newValue) {node.position.x = newValue}
    }
    open var y:CGFloat {
        get {return -node.position.y}
        set (newValue) {
            node.position.y = -newValue
        }
    }
    
    internal var yRaw:CGFloat {
        get {return node.position.y}
        set (newValue) {
            node.position.y = newValue
        }
    }
    internal func update(_ currentTime:CFTimeInterval) {
        dispatchEvent(Event(EventType.EnterFrame.rawValue,false))
    }
}
