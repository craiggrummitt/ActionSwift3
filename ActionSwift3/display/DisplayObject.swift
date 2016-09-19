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
    /**
     Indicates the alpha transparency value of the object specified. Valid values are 0 (fully transparent) to 1 (fully opaque). The default value is 1. Display objects with alpha set to 0 are active, even though they are invisible.
     */
    open var alpha:CGFloat {
        get {return node.alpha}
        set(newValue) {node.alpha = newValue}
    }
    /**
    Indicates the height of the display object, in points.
     **/
    open var height:CGFloat {
        return node.frame.height
    }
    /**
     Indicates the width of the display object, in points.
     **/
    open var width:CGFloat {
        return node.frame.width
    }
    /**
     Indicates the rotation of the DisplayObject instance, in degrees, from its original orientation. Values from 0 to 180 represent clockwise rotation; values from 0 to -180 represent counterclockwise rotation. Values outside this range are added to or subtracted from 360 to obtain a value within the range. For example, the statement my_video.rotation = 450 is the same as my_video.rotation = 90.
     **/
    open var rotation:CGFloat {
        get {return -node.zRotation * 180 / CGFloat(M_PI)}
        set(newValue) {node.zRotation = -newValue * CGFloat(M_PI) / 180}
    }
    /**
     Indicates the horizontal scale (percentage) of the object as applied from the registration point. The default registration point is (0,0). 1.0 equals 100% scale.
    **/
    open var scaleX:CGFloat {
        get {return node.xScale}
        set(newValue) {node.xScale = newValue}
    }
    /**
     Indicates the vertical scale (percentage) of the object as applied from the registration point. The default registration point is (0,0). 1.0 equals 100% scale.
     **/
    open var scaleY:CGFloat {
        get {return node.yScale}
        set(newValue) {node.yScale = newValue}
    }
    /**
     Indicates the x coordinate of the DisplayObject instance relative to the local coordinates of the parent DisplayObjectContainer.
     **/
    open var x:CGFloat {
        get {return node.position.x}
        set (newValue) {node.position.x = newValue}
    }
    /**
     Indicates the y coordinate of the DisplayObject instance relative to the local coordinates of the parent DisplayObjectContainer.
     **/
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
