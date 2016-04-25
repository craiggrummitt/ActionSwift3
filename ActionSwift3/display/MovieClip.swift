//
//  MovieClip.swift
//  ActionSwiftSK
//
//  Created by Craig on 7/05/2015.
//  Copyright (c) 2015 Interactive Coconut. All rights reserved.
//

import SpriteKit

/** 
Creates a movie clip from the provided textures and with the specified default framerate.
The movie will have the size of the first frame. 
*/
public class MovieClip: Sprite {
    let PLAYING_KEY = "playing"
    internal var spriteNode  = SpriteNode()
    internal var textureNames:[String] = []
    internal var imagesAtlas:SKTextureAtlas!
    internal var textures:[SKTexture] = []
    internal var mFPS:UInt
    private var initialWidth:CGFloat = 0
    private var initialHeight:CGFloat = 0
    
    public init(textureNames:[String], fps: UInt = 12, atlas:String = "images.atlas") {
        self.mFPS = fps
        super.init()
        self.setTextures(textureNames, atlas: atlas)
        play()
    }
    public func setTextures(textureNames:[String],atlas:String="images.atlas") {
        stop()
        //delete old spriteNode (and remove from parent)
        if (spriteNode.parent != nil) {
            spriteNode.removeFromParent()
        }
        self.textureNames = textureNames
        imagesAtlas = SKTextureAtlas(named: atlas)
        textures = []
        if (textureNames.length == 0) {return}
        for textureName in textureNames {
            let texture = imagesAtlas.textureNamed(textureName)
            textures.push(texture)
        }
        spriteNode = SpriteNode(texture: imagesAtlas.textureNamed(textureNames[0]))
        spriteNode.owner = self
        spriteNode.userInteractionEnabled = true
        spriteNode.anchorPoint = CGPoint(x: 0,y: 1)
        spriteNode.position.x = 0
        spriteNode.position.y = Stage.size.height
        node.addChild(spriteNode)
        
        initialWidth = spriteNode.frame.width
        initialHeight = spriteNode.frame.height
    }
    //public methods
    /** 
    gotoAndPlay works slightly different to AS3 - if you have loop set to false, it will work the same.
    However if you have loop set to true, it will loop from 'frame'.
    */
    public func gotoAndPlay(frame:UInt,fps: UInt = 12) {
        var frame = frame
        self.stop()
        if (frame == 0) {frame = 1}
        playTextures(Array(textures[(Int(frame)-1)..<textures.count]))
    }
    public func gotoAndStop(frame:UInt) {
        var frame = frame
        self.stop()
        if (frame == 0) {frame = 1}
        spriteNode.texture = textures[Int(frame)-1]
    }
    public func nextFrame() {
        self.stop()
        var nextFrameNo = currentFrame + 1
        if (nextFrameNo >= Int(numFrames)) {
            nextFrameNo = 0
        }
        spriteNode.texture = textures[nextFrameNo]
    }
    public func prevFrame() {
        self.stop()
        var prevFrameNo = currentFrame - 1
        if (prevFrameNo < 0) {
            prevFrameNo = Int(numFrames) - 1
        }
        spriteNode.texture = textures[prevFrameNo]
    }
    public func play(fps: UInt = 12) {
        self.stop()
        playTextures(textures)

    }
    
    //private helper funcs
    internal func playTextures(textures:[SKTexture]) {
        if (loop) {
            spriteNode.runAction(
                SKAction.repeatActionForever(
                    SKAction.animateWithTextures(textures, timePerFrame: 1 / Double(fps), resize: true, restore: false)
                ),
                withKey: PLAYING_KEY
            )
        } else {
            spriteNode.runAction(
                SKAction.animateWithTextures(textures, timePerFrame: 1 / Double(fps), resize: true, restore: false),
                withKey: PLAYING_KEY)
            
        }
    }
    public func stop() {
        spriteNode.removeAllActions()
    }
    //public properties
    /** Indicates if the clip will loop. */
    public var loop:Bool = true
    /** Indicates the total number of frames. */
    public var numFrames:UInt {
        return UInt(textures.length)
    }
    /** Get the current number of the frame. */
    public var currentFrame:Int {
        if let texture = spriteNode.texture {
            return textures.indexOf(texture)
        } else {
            return -1
        }
    }
    /** Indicates the fps of the movie clip */
    public var fps:UInt {
        return mFPS
    }
    public var isPlaying:Bool {
        return (spriteNode.actionForKey(PLAYING_KEY) != nil)
    }
    
    override public var height:CGFloat {
        get {
            return spriteNode.frame.height
        }
        set(newValue) {
            spriteNode.yScale = newValue / initialHeight
        }
    }
    override public var width:CGFloat {
        get {
            return spriteNode.frame.width
        }
        set(newValue) {
            spriteNode.xScale = newValue / initialWidth
        }
    }
    override public var scaleX:CGFloat {
        get {return spriteNode.xScale}
        set(newValue) {spriteNode.xScale = newValue}
    }
    override public var scaleY:CGFloat {
        get {return spriteNode.yScale}
        set(newValue) {spriteNode.yScale = newValue}
    }
    
    override public var rotation:CGFloat {
        get {return -spriteNode.zRotation * 180 / CGFloat(M_PI)}
        set(newValue) {spriteNode.zRotation = -newValue * CGFloat(M_PI) / 180}
    }
    override internal func enableUserInteraction(enabled:Bool) {
        //self.spriteNode.userInteractionEnabled = enabled
        super.enableUserInteraction(enabled)
    }
}
