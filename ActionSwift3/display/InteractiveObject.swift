//
//  InteractiveObject.swift
//  ActionSwiftSK
//
//  Created by Craig on 5/05/2015.
//  Copyright (c) 2015 Interactive Coconut. All rights reserved.
//

import UIKit

public class InteractiveObject: DisplayObject {
    override public init() {
        super.init()
        self.mouseEnabled = true

    }
    public var mouseEnabled:Bool {
        get {return self.node.userInteractionEnabled}
        set(newValue) {
            self.enableUserInteraction(newValue)
        }
    }
    internal func enableUserInteraction(enabled:Bool) {
    }
}
