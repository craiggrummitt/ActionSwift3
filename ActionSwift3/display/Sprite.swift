//
//  Sprite.swift
//  ActionSwiftSK
//
//  Created by Craig on 6/05/2015.
//  Copyright (c) 2015 Interactive Coconut. All rights reserved.
//

import SpriteKit

/**
Creates a Sprite. A sprite contains a graphics property that can be used to display shapes.
A sprite can also be dragged, via the `startDrag` method.
*/
open class Sprite: DisplayObjectContainer {
    open var graphics:Graphics!
    fileprivate var dragging = false
    fileprivate var initialLoc:CGPoint = CGPoint(x: 0, y: 0)
    fileprivate var initialTouch:CGPoint = CGPoint(x: 0, y: 0)
    override public init() {
        graphics = Graphics()
        super.init()
        graphics.makeOwner(self)
        //graphics.node.userInteractionEnabled = true
        node.insertChild(graphics.node, at: 0)
        self.addEventListener(InteractiveEventType.TouchBegin.rawValue, EventHandler(touchEventHandler, "touchEventHandler"))
    }
    override internal func enableUserInteraction(_ enabled:Bool) {
        super.enableUserInteraction(enabled)
        self.graphics.userInteractionEnabled = enabled
    }
    ///Start dragging the sprite
    open func startDrag() {
        dragging = true
        self.addEventListener(InteractiveEventType.TouchMove.rawValue, EventHandler(touchEventHandler, "touchEventHandler"))
    }
    func touchEventHandler(_ event:Event) -> Void {
        if let touchEvent = event as? TouchEvent {
            if touchEvent.type == InteractiveEventType.TouchBegin.rawValue {
                if (!dragging) {
                    if let touch = touchEvent.touches.first {
                        initialTouch = CGPoint(x: touch.stageX, y: touch.stageY)
                        initialLoc = CGPoint(x: self.x, y: self.y)
                    }
                }
            } else if touchEvent.type == InteractiveEventType.TouchMove.rawValue {
                if let _ = touchEvent.currentTarget as? DisplayObject {
                    if let touch = touchEvent.touches.first {
                        self.x = initialLoc.x + touch.stageX - initialTouch.x
                        self.y = initialLoc.y + touch.stageY - initialTouch.y
                    }
                }
            }
        }
        
    }
    ///Stop dragging the sprite
    open func stopDrag() {
        dragging = false
        self.removeEventListener(InteractiveEventType.TouchMove.rawValue, EventHandler(touchEventHandler, "touchEventHandler"))
        print("stop drag")
    }
    override internal func update(_ currentTime:CFTimeInterval) {
        super.update(currentTime)
    }
}
