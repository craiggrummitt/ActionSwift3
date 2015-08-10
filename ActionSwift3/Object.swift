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
public class Object:NSObject {
    
    override public init() {
        
    }
    
    public func toLocaleString()->String {
        return toString()
    }
    public func toString()->String {
        return ""
    }
}
