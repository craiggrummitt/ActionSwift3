//
//  SoundChannel.swift
//  ActionSwift
//
//  Created by Craig on 6/08/2015.
//  Copyright (c) 2015 Interactive Coconut. All rights reserved.
//

import SpriteKit
import AVFoundation

public class SoundChannel: EventDispatcher,AVAudioPlayerDelegate {
    var audioPlayer:AVAudioPlayer = AVAudioPlayer()
    
    internal func play(name:String,startTime:Number=0, loops:int=1) {
        var pathExtension = name.pathExtension
        if (pathExtension == "") {pathExtension = "mp3"}
        let path = NSBundle.mainBundle().pathForResource(name.stringByDeletingPathExtension, ofType: pathExtension)
        if let path = path {
            let url = NSURL.fileURLWithPath(path)
            do {
                try self.audioPlayer = AVAudioPlayer(contentsOfURL: url)
            } catch {
                print("Error: Audio player not instantiated")
            }
            self.audioPlayer.delegate = self
            self.audioPlayer.numberOfLoops = loops
            if (startTime > 0) {
                self.audioPlayer.currentTime = NSTimeInterval(startTime)
            }
            self.audioPlayer.play()
        }
    }
    func stop() {
        self.audioPlayer.stop()
    }
    public func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        dispatchEvent(Event(EventType.SoundComplete.rawValue,false))
    }
    public func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer, error: NSError?) {
        dispatchEvent(Event(EventType.SoundError.rawValue,false))
    }
}
