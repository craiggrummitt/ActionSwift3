//
//  Event.swift
//  ActionSwiftSK
//
//  Created by Craig on 5/05/2015.
//  Copyright (c) 2015 Interactive Coconut. All rights reserved.
//


import UIKit

/**
All basic event types.
*/
public enum EventType:String {
    /** Event type for a display object that is added to a parent. */
    case Added = "Added"
    /** Event type for a display object that is entering a new frame. */
    case EnterFrame = "EnterFrame"
    /** Event type for a display object that is removed from its parent. */
    case Removed = "Removed"
    /** Event type that may be used whenever something finishes. */
    case Complete = "Complete"
    /** Sound Event for when a sound finishes playing */
    case SoundComplete = "soundComplete"
    /** Sound Event for an error */
    case SoundError = "soundError"
}
/** Event objects are passed as parameters to event listeners when an event occurs.

  EventDispatchers create instances of this class and send them to registered listeners.
  An event object contains information that characterizes an event, most importantly the
  event type and if the event bubbles. The target of an event is the object that
  dispatched it.

  For some event types, this information is sufficient; other events may need additional
  information to be carried to the listener. In that case, you can subclass "Event" and add
  properties with all the information you require. The "EnterFrameEvent" is an example for
  this practice; it adds a property about the time that has passed since the last frame.

  Furthermore, the event class contains methods that can stop the event from being
  processed by other listeners - either completely or at the next bubble stage.

  @see EventDispatcher
*/
open class Event: Object {
    fileprivate var mTarget:EventDispatcher?;
    fileprivate var mCurrentTarget:EventDispatcher?;
    fileprivate var mType:String;
    fileprivate var mBubbles:Bool;
    fileprivate var mStopsPropagation:Bool = false;
    fileprivate var mStopsImmediatePropagation:Bool = false;
    public init(_ type:String,_ bubbles:Bool = true) {
        self.mType = type
        self.mBubbles = bubbles
    }
    public init(_ type:EventType,_ bubbles:Bool = true) {
        self.mType = type.rawValue
        self.mBubbles = bubbles
    }
    /** Prevents listeners at the next bubble stage from receiving the event. */
    open func stopPropagation() {
        mStopsPropagation = true;
    }
    /** Prevents any other listeners from receiving the event. */
    open func stopImmediatePropagation() {
        mStopsImmediatePropagation = true
        mStopsPropagation = true
    }
    override open func toString()->String {
       return "\(String(describing:Swift.type(of:self))) type=\(mType) bubbles=\(mBubbles)"
    }
    /** @private */
    internal func setTarget(_ target:EventDispatcher){
        mTarget = target
    }
    /** @private */
    internal func setCurrentTarget(_ currentTarget:EventDispatcher) {
        mCurrentTarget = currentTarget
    }
    /** @private */
    internal var stopsPropagation:Bool { return mStopsPropagation }
    /** @private */
    internal var stopsImmediatePropagation:Bool { return mStopsImmediatePropagation }
    /** Indicates if event will bubble. */
    open var bubbles:Bool { return mBubbles }
    
    /** The object that dispatched the event. */
    open var target:EventDispatcher? { return mTarget }
    
    /** The object the event is currently bubbling at. */
    open var currentTarget:EventDispatcher? { return mCurrentTarget }
    
    /** A string that identifies the event. */
    open var type:String { return mType }
}
