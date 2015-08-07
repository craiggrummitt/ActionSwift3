//
//  Touch.swift
//  ActionSwiftSK
//
//  Created by Craig on 6/05/2015.
//  Copyright (c) 2015 Interactive Coconut. All rights reserved.
//

import UIKit

/**
All information about a single touch.
*/
public class Touch: Object {
    public var localX:CGFloat
    public var localY:CGFloat
    public var stageX:CGFloat
    public var stageY:CGFloat
    public var sizeX:CGFloat
    public var sizeY:CGFloat
    public init(localX:CGFloat,localY:CGFloat,stageX:CGFloat,stageY:CGFloat,sizeX:CGFloat,sizeY:CGFloat) {
        self.localX = localX
        self.localY = localY
        self.stageX = stageX
        self.stageY = stageY
        self.sizeX = sizeX
        self.sizeY = sizeY
    }
}
