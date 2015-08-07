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
    case Up
    case Down
}
/**
Display a button with two states. A state can be represented by a DisplayObject, or any subclass thereof, eg. MovieClip or Sprite.
*/
public class SimpleButton: InteractiveObject {
    
    private var upState:DisplayObject
    private var downState:DisplayObject
    
    public init(upState:DisplayObject,downState:DisplayObject) {
        //keeping non-optionals honest
        self.upState = upState
        self.downState = downState
        self.currentState = .Up
        self.enabled = true
        
        super.init()
        
        self.initProperties(upState, downState)
    }
    //required to ensure didSet gets called
    private func initProperties(upState:DisplayObject, _ downState:DisplayObject) {
        self.upState = upState
        self.downState = downState
        self.currentState = .Up
        self.enabled = true
    }
    /** The current state of the button. Unlike AS3, this state can be set manually. */
    public var currentState:SimpleButtonState {
        didSet {
            switch currentState {
            case .Up:
                self.node.removeAllChildren()
                self.node.addChild(upState.node)
            case .Down:
                self.node.removeAllChildren()
                self.node.addChild(downState.node)
            }
            self.setUpEventListeners()
        }
    }
    public var enabled:Bool {
        didSet {
            setUpEventListeners()
        }
    }
    private func setUpEventListeners() {
        self.removeStateEventListeners()
        if (enabled) {
            switch currentState {
            case .Up:
                upState.addEventListener(InteractiveEventType.TouchBegin.rawValue, EventHandler(touchEventHandler, "touchEventHandler"))
            case .Down:
                upState.addEventListener(InteractiveEventType.TouchEnd.rawValue, EventHandler(touchEventHandler, "touchEventHandler"))
            }
        }
    }
    private func removeStateEventListeners() {
        upState.removeEventListeners(InteractiveEventType.TouchBegin.rawValue)
        upState.removeEventListeners(InteractiveEventType.TouchEnd.rawValue)
    }
    private func touchEventHandler(event:Event) -> Void {
        if let touchEvent = event as? TouchEvent {
            if touchEvent.type == InteractiveEventType.TouchBegin.rawValue {
                if (self.currentState == .Up) {
                    self.currentState = .Down
                }
            } else if touchEvent.type == InteractiveEventType.TouchEnd.rawValue {
                if (self.currentState == .Down) {
                    self.currentState = .Up
                }
            }
        }
        dispatchEvent(event)
    }
}
