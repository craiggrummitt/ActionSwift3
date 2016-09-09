//
//  Sound.swift
//  ActionSwift
//
//  Created by Craig on 6/08/2015.
//  Copyright (c) 2015 Interactive Coconut. All rights reserved.
//

import SpriteKit

/**
Be sure to store either the sound or soundChannel in an instance variable, as the sound will be "garbage collected"
(or the Swift equivalent at least, *deinitialized* when there are no references to it)
*/
open class Sound: EventDispatcher {
    fileprivate var name:String
    fileprivate var soundChannel:SoundChannel = SoundChannel()
    
    public init(name:String) {
        self.name = name
        
    }
    open func load(_ name:String) {
        self.name = name
    }
    ///Returns a SoundChannel, which you can use to *stop* the Sound.
    open func play(_ startTime:Number = 0, loops:int = 0)->SoundChannel {
        soundChannel = SoundChannel()
        soundChannel.play(self.name,startTime:startTime, loops:loops)
        return soundChannel
    }
}
