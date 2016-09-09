//
//  InteractiveObject.swift
//  ActionSwiftSK
//
//  Created by Craig on 5/05/2015.
//  Copyright (c) 2015 Interactive Coconut. All rights reserved.
//

import UIKit

open class InteractiveObject: DisplayObject {
    override public init() {
        super.init()
        self.mouseEnabled = true

    }
    open var mouseEnabled:Bool {
        get {return self.node.isUserInteractionEnabled}
        set(newValue) {
            self.enableUserInteraction(newValue)
        }
    }
    internal func enableUserInteraction(_ enabled:Bool) {
    }
}
