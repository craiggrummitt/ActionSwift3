//
//  GameViewController.swift
//  ActionSwiftSK
//
//  Created by Craig on 5/05/2015.
//  Copyright (c) 2015 Interactive Coconut. All rights reserved.
//

import UIKit
import SpriteKit


class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let stage = Stage(self.view as! SKView)
        
        let sprite = Sprite()
        sprite.graphics.beginFill(UIColor.redColor())
        sprite.graphics.drawRect(10,10,10,10)
        sprite.graphics.drawCircle(100, 100, 10)
        sprite.graphics.drawCircle(200, 200, 10)
        sprite.addEventListener(EventType.Added.rawValue, EventHandler(spriteAdded, "spriteAdded"))
        sprite.addEventListener(InteractiveEventType.TouchBegin.rawValue, EventHandler(spriteTouched, "spriteTouched"))
        sprite.addEventListener(InteractiveEventType.TouchEnd.rawValue, EventHandler(spriteTouched, "spriteTouched"))
        sprite.objectName = "shapes"
        stage.addChild(sprite)
    }
    func spriteAdded(event:Event) -> Void {
        trace("sprite added ")
    }
    func spriteTouched(event:Event) -> Void {
        if let touchEvent = event as? TouchEvent {
            if let currentTarget = touchEvent.currentTarget as? Sprite {
                if touchEvent.type == InteractiveEventType.TouchBegin.rawValue {
                    //trace("sprite touched \(currentTarget.objectName) - \(touchEvent.type)")
                    currentTarget.startDrag()
                } else if touchEvent.type == InteractiveEventType.TouchEnd.rawValue {
                    currentTarget.stopDrag()
                }
            }
        }
    }
    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
