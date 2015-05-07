//
//  TouchEvent.swift
//  ActionSwiftSK
//
//  Created by Craig on 6/05/2015.
//  Copyright (c) 2015 Interactive Coconut. All rights reserved.
//

import UIKit
public enum InteractiveEventType:String {
    case TouchBegin = "TouchBegin"
    case TouchEnd = "TouchEnd"
    case TouchMove = "TouchMove"
}
public class TouchEvent: Event {
    public var touches:[Touch]
    init(_ type:InteractiveEventType,_ touches:[Touch],_ bubbles:Bool = true) {
        self.touches = touches
        super.init(type.rawValue, bubbles)
    }
}
