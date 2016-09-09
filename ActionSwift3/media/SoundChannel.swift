//
//  SoundChannel.swift
//  ActionSwift
//
//  Created by Craig on 6/08/2015.
//  Copyright (c) 2015 Interactive Coconut. All rights reserved.
//

import SpriteKit
import AVFoundation

open class SoundChannel: EventDispatcher,AVAudioPlayerDelegate {
    var audioPlayer:AVAudioPlayer = AVAudioPlayer()
    
    internal func play(_ name:String,startTime:Number=0, loops:int=1) {
        var pathExtension = name.pathExtension
        if (pathExtension == "") {pathExtension = "mp3"}
        let path = Bundle.main.path(forResource: name.stringByDeletingPathExtension, ofType: pathExtension)
        if let path = path {
            let url = URL(fileURLWithPath: path)
            do {
                try self.audioPlayer = AVAudioPlayer(contentsOf: url)
            } catch {
                print("Error: Audio player not instantiated")
            }
            self.audioPlayer.delegate = self
            self.audioPlayer.numberOfLoops = loops
            if (startTime > 0) {
                self.audioPlayer.currentTime = TimeInterval(startTime)
            }
            self.audioPlayer.play()
        }
    }
    func stop() {
        self.audioPlayer.stop()
    }
    open func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        dispatchEvent(Event(EventType.SoundComplete.rawValue,false))
    }
    open func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        dispatchEvent(Event(EventType.SoundError.rawValue,false))
    }
}
