//
//  SimpleButton.swift
//  ActionSwift
//
//  Created by Craig on 5/08/2015.
//  Copyright (c) 2015 Interactive Coconut. All rights reserved.
//

import UIKit
/**
SimpleButton's currentState is set to this.
*/
public enum SimpleButtonState {
    case up
    case down
}
/**
Display a button with two states. A state can be represented by a DisplayObject, or any subclass thereof, eg. MovieClip or Sprite.
*/
open class SimpleButton: InteractiveObject {
    
    fileprivate var upState:DisplayObject
    fileprivate var downState:DisplayObject
    
    public init(upState:DisplayObject,downState:DisplayObject) {
        //keeping non-optionals honest
        self.upState = upState
        self.downState = downState
        self.currentState = .up
        self.enabled = true
        
        super.init()
        
        self.initProperties(upState, downState)
    }
    //required to ensure didSet gets called
    fileprivate func initProperties(_ upState:DisplayObject, _ downState:DisplayObject) {
        self.upState = upState
        self.downState = downState
        self.currentState = .up
        self.enabled = true
    }
    /** The current state of the button. Unlike AS3, this state can be set manually. */
    open var currentState:SimpleButtonState {
        didSet {
            switch currentState {
            case .up:
                self.node.removeAllChildren()
                self.node.addChild(upState.node)
            case .down:
                self.node.removeAllChildren()
                self.node.addChild(downState.node)
            }
            self.setUpEventListeners()
        }
    }
    open var enabled:Bool {
        didSet {
            setUpEventListeners()
        }
    }
    fileprivate func setUpEventListeners() {
        self.removeStateEventListeners()
        if (enabled) {
            switch currentState {
            case .up:
                upState.addEventListener(InteractiveEventType.TouchBegin.rawValue, EventHandler(touchEventHandler, "touchEventHandler"))
            case .down:
                upState.addEventListener(InteractiveEventType.TouchEnd.rawValue, EventHandler(touchEventHandler, "touchEventHandler"))
            }
        }
    }
    fileprivate func removeStateEventListeners() {
        upState.removeEventListeners(InteractiveEventType.TouchBegin.rawValue)
        upState.removeEventListeners(InteractiveEventType.TouchEnd.rawValue)
    }
    fileprivate func touchEventHandler(_ event:Event) -> Void {
        if let touchEvent = event as? TouchEvent {
            if touchEvent.type == InteractiveEventType.TouchBegin.rawValue {
                if (self.currentState == .up) {
                    self.currentState = .down
                }
            } else if touchEvent.type == InteractiveEventType.TouchEnd.rawValue {
                if (self.currentState == .down) {
                    self.currentState = .up
                }
            }
        }
        dispatchEvent(event)
    }
}
