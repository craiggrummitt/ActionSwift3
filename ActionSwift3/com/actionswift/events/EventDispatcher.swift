//
//  EventDispatcher.swift
//  ActionSwiftSK
//
//  Created by Craig on 5/05/2015.
//  Copyright (c) 2015 Interactive Coconut. All rights reserved.
//



import UIKit
/** The EventDispatcher class is the base class for all classes that dispatch events.
  This is the Starling version of the Flash class with the same name.

  The event mechanism is a key feature of Starling's architecture. Objects can communicate
  with each other through events. Compared the the Flash event system, Starling's event system
  was simplified. The main difference is that Starling events have no "Capture" phase.
  They are simply dispatched at the target and may optionally bubble up. They cannot move
  in the opposite direction.

  As in the conventional Flash classes, display objects inherit from EventDispatcher
  and can thus dispatch events. Beware, though, that the Starling event classes are
  <em>not compatible with Flash events:</em> Starling display objects dispatch
  Starling events, which will bubble along Starling display objects - but they cannot
  dispatch Flash events or bubble along Flash display objects.

  @see Event
  @see starling.display.DisplayObject DisplayObject
*/
open class EventDispatcher: Object {
    fileprivate var mEventListeners = Dictionary<String, [EventHandler]>()

    /** Helper object. */
    fileprivate static var sBubbleChains:[[EventDispatcher]] = []
    /** Registers an event listener at a certain object. */
    open func addEventListener(_ type:String,_ listener:EventHandler) {
        if var listeners = mEventListeners[type] {
            listeners.push(listener)
            mEventListeners[type] = listeners
        } else {
            mEventListeners[type] = [listener]
        }
    }
    /** Removes an event listener from the object. */
    open func removeEventListener(_ type:String,_ listener:EventHandler) {
        if let listeners = mEventListeners[type] {
            mEventListeners[type] = nil
            let numListeners = listeners.length
            var remainingListeners:[EventHandler] = []
            for i in 0..<numListeners {
                if (listeners[i].functionName != listener.functionName) {
                    remainingListeners.push(listeners[i])
                    mEventListeners[type] = remainingListeners
                }
            }
        }
    }
    /** Removes all event listeners with a certain type, or all of them if type is null.
    *  Be careful when removing all event listeners: you never know who else was listening. */
    open func removeEventListeners(_ type:String?) {
        if let type = type {
            mEventListeners[type] = nil
        } else {
            mEventListeners = Dictionary<String, [EventHandler]>()
        }
    }
    /** Dispatches an event to all objects that have registered listeners for its type.
    *  If an event with enabled 'bubble' property is dispatched to a display object, it will
    *  travel up along the line of parents, until it either hits the root object or someone
    *  stops its propagation manually. */
    open func dispatchEvent(_ event:Event) {
        let bubbles = event.bubbles
        if (!bubbles && (mEventListeners.count == 0 || (mEventListeners[event.type] == nil))) {
            return // no need to do anything
        }
    
        // we save the current target and restore it later;
        // this allows users to re-dispatch events without creating a clone.
        let previousTarget = event.target
        event.setTarget(self);
    
        if (bubbles && self is DisplayObject) {
            bubbleEvent(event)
        } else {
            invokeEvent(event)
        }
        if let previousTarget = previousTarget {
            event.setTarget(previousTarget)
        }
    }
    
    /** @private
    *  Invokes an event on the current object. This method does not do any bubbling, nor
    *  does it back-up and restore the previous target on the event. The 'dispatchEvent'
    *  method uses this method internally. */
    @discardableResult internal func invokeEvent(_ event:Event)->Bool {
        if let listeners = mEventListeners[event.type] {
            let numListeners = listeners.length
            event.setCurrentTarget(self)
            
            // we can enumerate directly over the vector, because:
            // when somebody modifies the list while we're looping, "addEventListener" is not
            // problematic, and "removeEventListener" will create a new Vector, anyway.
            for i in 0..<numListeners {
                let listener = listeners[i]
                listener.function(event)
                if (event.stopsImmediatePropagation) {
                    trace("STOPPING Propogation")
                    return true
                }
            }
            return event.stopsPropagation
        } else {
            return false
        }
    }
    
    /** @private */
    internal func bubbleEvent(_ event:Event) {
        // we determine the bubble chain before starting to invoke the listeners.
        // that way, changes done by the listeners won't affect the bubble chain.
        if let element = self as? DisplayObject {
            var chain:[EventDispatcher]
            var length = 1
        
            if (EventDispatcher.sBubbleChains.length > 0) {
                chain = EventDispatcher.sBubbleChains.pop()!
                if (chain.count==0) {
                    chain.push(element)
                } else {
                    chain[0] = element
                }
            } else {
                chain = [element]
            }
        
            var elementToLoop:DisplayObject? = element
            while let elementParent = elementToLoop?.parent {
                length += 1
                elementToLoop = elementParent
                chain.push(elementParent)
            }
            for i in 0..<length {
                let stopPropagation:Bool = chain[i].invokeEvent(event)
                if (stopPropagation) {
                    break;
                }
            }
        
            chain = []
            EventDispatcher.sBubbleChains.push(chain)
        }
    }
    /** Returns if there are listeners registered for a certain event type. */
    open func hasEventListener(_ type:String)->Bool {
        if let listeners = mEventListeners[type] {
            return listeners.length != 0
        }
        return false
    }
}



