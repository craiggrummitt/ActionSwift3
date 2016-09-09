//
//  Object.swift
//  ActionSwiftSK
//
//  Created by Craig on 5/05/2015.
//  Copyright (c) 2015 Interactive Coconut. All rights reserved.
//

import UIKit

/**
The base class of *everything* in AS3...
*/
open class Object:NSObject {
    
    override public init() {
        
    }
    
    open func toLocaleString()->String {
        return toString()
    }
    open func toString()->String {
        return ""
    }
}
