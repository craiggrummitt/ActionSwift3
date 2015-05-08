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
    let walkingTextures = ["walking1","walking2","walking3","walking4","walking5","walking6","walking7","walking8","walking9"]
    override func viewDidLoad() {
        super.viewDidLoad()
        //create stage
        let stage = Stage(self.view as! SKView)
        //create a sprite, add a rectangle and a circle to its graphics property
        let sprite = Sprite()
        sprite.graphics.beginFill(UIColor.redColor())
        sprite.graphics.drawRect(10,10,100,44)
        sprite.graphics.beginFill(UIColor.yellowColor())
        sprite.graphics.drawCircle(Stage.size.width - 30, 30, 22)
        sprite.objectName = "shapes"
        stage.addChild(sprite)
        //create a movieclip, add textures from 'images.atlas', then control it just as you would in AS3
        let movieClip = MovieClip(textureNames: walkingTextures)
        movieClip.x = 0
        movieClip.y = Stage.size.height - movieClip.height
        movieClip.addEventListener(InteractiveEventType.TouchBegin.rawValue, EventHandler(spriteTouched, "spriteTouched"))
        movieClip.addEventListener(InteractiveEventType.TouchEnd.rawValue, EventHandler(spriteTouched, "spriteTouched"))
        stage.addChild(movieClip)

    }
    func spriteAdded(event:Event) -> Void {
        trace("sprite added ")
    }
    func spriteTouched(event:Event) -> Void {
        if let touchEvent = event as? TouchEvent {
            if let currentTarget = touchEvent.currentTarget as? Sprite {
                //drag/drop
                if touchEvent.type == InteractiveEventType.TouchBegin.rawValue {
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
