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
public class DisplayObject: EventDispatcher, StageSceneProtocol {
    public weak var parent:DisplayObjectContainer?
    public var name:String = ""
    public weak var stage:Stage?
    
    internal var node = SKNode()
    
    override public init() {
        super.init()

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
    internal func update(currentTime:CFTimeInterval) {
        dispatchEvent(Event(EventType.EnterFrame.rawValue,false))
    }
}
