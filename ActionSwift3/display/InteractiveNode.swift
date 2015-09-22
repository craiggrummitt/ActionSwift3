//
//  InteractiveNode.swift
//  ActionSwift
//
//  Created by Craig on 5/08/2015.
//  Copyright (c) 2015 Interactive Coconut. All rights reserved.
//

import SpriteKit

class InteractiveNode: SKNode {
    weak var owner:DisplayObject?
    //Interactive
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        dispatchTouches(.TouchBegin, touches: touches)
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        dispatchTouches(.TouchEnd, touches: touches)
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        dispatchTouches(.TouchMove, touches: touches)
    }
    func dispatchTouches(touchType:InteractiveEventType,touches:Set<UITouch>) {
        if let owner = owner as? InteractiveObject {
            var touchesToDispatch:[Touch] = []
            for touch in touches {
                if let parent = parent {
                    let loc = touch.locationInNode(parent)
                    let stageLoc = touch.locationInView(self.scene?.view)
                    touchesToDispatch.push(Touch(localX: loc.x, localY: loc.y, stageX: stageLoc.x, stageY: stageLoc.y, sizeX: touch.majorRadius, sizeY: touch.majorRadius))
                }
            }
            owner.dispatchEvent(TouchEvent(touchType, touchesToDispatch))
        }
    }

}
