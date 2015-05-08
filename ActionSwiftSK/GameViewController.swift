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
    var movieClip:MovieClip!
    override func viewDidLoad() {
        super.viewDidLoad()
        //create stage
        let stage = Stage(self.view as! SKView)
        //create a sprite, add a rectangle and a circle to its graphics property
        let playButtonX = Stage.size.width - 30
        let play = Sprite()
        play.graphics.beginFill(UIColor.whiteColor())
        play.graphics.drawCircle(playButtonX, 30, 22)
        play.graphics.beginFill(UIColor.blueColor())
        play.graphics.drawTriangle(playButtonX - 8, 20, playButtonX - 8, 40, playButtonX + 12, 30)
        play.name = "play"
        play.addEventListener(InteractiveEventType.TouchBegin.rawValue, EventHandler(spriteTouched, "spriteTouched"))
        stage.addChild(play)
        let stop = Sprite()
        stop.graphics.beginFill(UIColor.whiteColor())
        stop.graphics.drawRect(10,10,44,44)
        stop.graphics.beginFill(UIColor.redColor())
        stop.graphics.drawRect(20,20,24,24)
        stop.name = "stop"
        stop.addEventListener(InteractiveEventType.TouchBegin.rawValue, EventHandler(spriteTouched, "spriteTouched"))
        stage.addChild(stop)
        //create a movieclip, add textures from 'images.atlas', then control it just as you would in AS3
        movieClip = MovieClip(textureNames: walkingTextures)
        movieClip.x = 0
        movieClip.y = Stage.size.height - movieClip.height
        movieClip.addEventListener(InteractiveEventType.TouchBegin.rawValue, EventHandler(spriteTouched, "spriteTouched"))
        movieClip.addEventListener(InteractiveEventType.TouchEnd.rawValue, EventHandler(spriteTouched, "spriteTouched"))
        movieClip.name = "walkingman"
        stage.addChild(movieClip)

    }
    func spriteAdded(event:Event) -> Void {
        trace("sprite added ")
    }
    func spriteTouched(event:Event) -> Void {
        if let touchEvent = event as? TouchEvent {
            if let currentTarget = touchEvent.currentTarget as? Sprite {
                if (currentTarget.name == "walkingman") {
                    //drag/drop
                    if touchEvent.type == InteractiveEventType.TouchBegin.rawValue {
                        currentTarget.startDrag()
                    } else if touchEvent.type == InteractiveEventType.TouchEnd.rawValue {
                        currentTarget.stopDrag()
                    }
                } else if (currentTarget.name == "play") {
                    movieClip.play()
                } else if (currentTarget.name == "stop") {
                    movieClip.stop()
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
