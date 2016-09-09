//
//  TouchEvent.swift
//  ActionSwiftSK
//
//  Created by Craig on 6/05/2015.
//  Copyright (c) 2015 Interactive Coconut. All rights reserved.
//

import UIKit

/**
All interactive event types
*/
public enum InteractiveEventType:String {
    case TouchBegin = "TouchBegin"
    case TouchEnd = "TouchEnd"
    case TouchMove = "TouchMove"
}
/**
A custom Event class, with information about touches.
*/
open class TouchEvent: Event {
    open var touches:[Touch]
    public init(_ type:InteractiveEventType,_ touches:[Touch],_ bubbles:Bool = true) {
        self.touches = touches
        super.init(type.rawValue, bubbles)
    }
}
