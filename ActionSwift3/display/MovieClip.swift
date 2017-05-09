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
open class MovieClip: Sprite {
    let PLAYING_KEY = "playing"
    internal var spriteNode  = SpriteNode()
    internal var textureNames:[String] = []
    internal var imagesAtlas:SKTextureAtlas!
    internal var textures:[SKTexture] = []
    internal var mFPS:UInt
    fileprivate var initialWidth:CGFloat = 0
    fileprivate var initialHeight:CGFloat = 0
    
    public init(textureNames:[String], fps: UInt = 12, atlas:String = "images.atlas") {
        self.mFPS = fps
        super.init()
        self.setTextures(textureNames, atlas: atlas)
        play()
    }
    open func setTextures(_ textureNames:[String],atlas:String="images.atlas") {
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
        spriteNode.isUserInteractionEnabled = true
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
    open func gotoAndPlay(_ frame:UInt,fps: UInt = 12) {
        var frame = frame
        self.stop()
        if (frame == 0) {frame = 1}
        playTextures(Array(textures[(Int(frame)-1)..<textures.count]))
    }
    open func gotoAndStop(_ frame:UInt) {
        var frame = frame
        self.stop()
        if (frame == 0) {frame = 1}
        spriteNode.texture = textures[Int(frame)-1]
    }
    open func nextFrame() {
        self.stop()
        var nextFrameNo = currentFrame + 1
        if (nextFrameNo >= Int(numFrames)) {
            nextFrameNo = 0
        }
        spriteNode.texture = textures[nextFrameNo]
    }
    open func prevFrame() {
        self.stop()
        var prevFrameNo = currentFrame - 1
        if (prevFrameNo < 0) {
            prevFrameNo = Int(numFrames) - 1
        }
        spriteNode.texture = textures[prevFrameNo]
    }
    open func play(_ fps: UInt = 12) {
        self.stop()
        playTextures(textures)

    }
    
    //private helper funcs
    internal func playTextures(_ textures:[SKTexture]) {
        if (loop) {
            spriteNode.run(
                SKAction.repeatForever(
                    SKAction.animate(with: textures, timePerFrame: 1 / Double(fps), resize: true, restore: false)
                ),
                withKey: PLAYING_KEY
            )
        } else {
            spriteNode.run(
                SKAction.animate(with: textures, timePerFrame: 1 / Double(fps), resize: true, restore: false),
                withKey: PLAYING_KEY)
            
        }
    }
    open func stop() {
        spriteNode.removeAllActions()
    }
    //public properties
    /** Indicates if the clip will loop. */
    open var loop:Bool = true
    /** Indicates the total number of frames. */
    open var numFrames:UInt {
        return UInt(textures.length)
    }
    /** Get the current number of the frame. */
    open var currentFrame:Int {
        if let texture = spriteNode.texture {
            return textures.index(of: texture)!
        } else {
            return -1
        }
    }
    /** Indicates the fps of the movie clip */
    open var fps:UInt {
        return mFPS
    }
    open var isPlaying:Bool {
        return (spriteNode.action(forKey: PLAYING_KEY) != nil)
    }
    
    override open var height:CGFloat {
        get {
            return spriteNode.frame.height
        }
        set(newValue) {
            spriteNode.yScale = newValue / initialHeight
        }
    }
    override open var width:CGFloat {
        get {
            return spriteNode.frame.width
        }
        set(newValue) {
            spriteNode.xScale = newValue / initialWidth
        }
    }
    override open var scaleX:CGFloat {
        get {return spriteNode.xScale}
        set(newValue) {spriteNode.xScale = newValue}
    }
    override open var scaleY:CGFloat {
        get {return spriteNode.yScale}
        set(newValue) {spriteNode.yScale = newValue}
    }
    
    override open var rotation:CGFloat {
        get {return -spriteNode.zRotation * 180 / CGFloat.pi}
        set(newValue) {spriteNode.zRotation = -newValue * CGFloat.pi / 180}
    }
    override internal func enableUserInteraction(_ enabled:Bool) {
        //self.spriteNode.userInteractionEnabled = enabled
        super.enableUserInteraction(enabled)
    }
}
