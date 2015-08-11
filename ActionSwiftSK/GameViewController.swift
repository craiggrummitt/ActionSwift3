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
    var sound:Sound = Sound(name: "")
    override func viewDidLoad() {
        super.viewDidLoad()
        //create stage
        let stage = Stage(self.view as! SKView)
        
        //------------------------------------------------------------------------------------------------------------------
        //create a simple stop button
        
        //create two sprites for up and down states for the stop button
        //add a couple of rectangles to its graphics property to make a stop symbol
        let stopUpState = Sprite()
        stopUpState.graphics.beginFill(UIColor.whiteColor())
        stopUpState.graphics.drawRect(0,0,44,44)
        stopUpState.graphics.beginFill(UIColor(hex:"#B21212"))
        stopUpState.graphics.drawRect(10,10,24,24)
        
        let stopDownState = Sprite()
        stopDownState.graphics.beginFill(UIColor.whiteColor())
        stopDownState.graphics.drawRect(0,0,44,44)
        stopDownState.graphics.beginFill(UIColor(hex:"#FF0000"))
        stopDownState.graphics.drawRect(8,8,28,28)

        let stop = SimpleButton(upState: stopUpState, downState: stopDownState)

        stop.x = 10
        stop.y = 10
        stop.name = "stop"
        stop.addEventListener(InteractiveEventType.TouchBegin.rawValue, EventHandler(spriteTouched, "spriteTouched"))
        stage.addChild(stop)
        
        
        //------------------------------------------------------------------------------------------------------------------
        //create a simple play button
        
        //create two sprites for up and down states for the play button
        //add a circle and triangle to its graphics property to make a play symbol
        let playUpState = Sprite()
        playUpState.graphics.beginFill(UIColor.whiteColor())
        playUpState.graphics.drawCircle(22, 22, 22)
        playUpState.graphics.beginFill(UIColor(hex:"#0971B2"))
        playUpState.graphics.drawTriangle(14, 12, 14, 32, 34, 22)
        
        let playDownState = Sprite()
        playDownState.graphics.beginFill(UIColor.whiteColor())
        playDownState.graphics.drawCircle(22, 22, 22)
        playDownState.graphics.beginFill(UIColor(hex:"#1485CC"))
        playDownState.graphics.drawTriangle(12, 10, 12, 34, 38, 22)
        
        let play = SimpleButton(upState: playUpState, downState: playDownState)
        play.x = Stage.size.width - 54
        play.y = 10
        play.name = "play"
        play.addEventListener(InteractiveEventType.TouchBegin.rawValue, EventHandler(spriteTouched, "spriteTouched"))
        stage.addChild(play)
        
        //------------------------------------------------------------------------------------------------------------------
        //create a movieclip, add textures from 'images.atlas', then control it just as you would in AS3
        movieClip = MovieClip(textureNames: walkingTextures)
        movieClip.x = 0
        movieClip.y = Stage.size.height - movieClip.height
        movieClip.addEventListener(InteractiveEventType.TouchBegin.rawValue, EventHandler(spriteTouched, "spriteTouched"))
        movieClip.addEventListener(InteractiveEventType.TouchEnd.rawValue, EventHandler(spriteTouched, "spriteTouched"))
        movieClip.name = "walkingman"
        stage.addChild(movieClip)
        
        //------------------------------------------------------------------------------------------------------------------
        //create a textfield, apply text formatting with a TextFormat object
        let text = TextField()
        text.width = 200
        text.text = "Walking man"
        
        let textFormat = TextFormat(font: "ArialMT", size: 20, leading: 20, color: UIColor.blackColor(),align:.Center)
        text.defaultTextFormat = textFormat
        
        text.x = (Stage.stageWidth / 2) - 100
        text.y = 20
        stage.addChild(text)


    }
    func spriteAdded(event:Event) -> Void {
        trace("sprite added ")
    }
    func spriteTouched(event:Event) -> Void {
        if let touchEvent = event as? TouchEvent {
            if let currentTarget = touchEvent.currentTarget as? DisplayObject {
                if (currentTarget.name == "walkingman") {
                    //drag/drop
                    if let currentTarget = currentTarget as? Sprite {
                        if touchEvent.type == InteractiveEventType.TouchBegin.rawValue {
                            currentTarget.startDrag()
                        } else if touchEvent.type == InteractiveEventType.TouchEnd.rawValue {
                            currentTarget.stopDrag()
                        }
                    }
                } else if (currentTarget.name == "play") {
                    sound = Sound(name: "ButtonTap.wav")
                    sound.play()
                    movieClip.play()
                } else if (currentTarget.name == "stop") {
                    sound = Sound(name: "SecondBeep.wav")
                    sound.play()
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
