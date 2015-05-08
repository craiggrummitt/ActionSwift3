//
//  Global.swift
//  ActionSwiftSK
//
//  Created by Craig on 6/05/2015.
//  Copyright (c) 2015 Interactive Coconut. All rights reserved.
//

import UIKit

public func ==(lhs: DisplayObject, rhs: DisplayObject) -> Bool {
    return lhs == rhs
}
public func trace(parms:String ...) {
    println(parms)
}
public func trace(parms:Int) {
    println(parms)
}
public func trace(parms:CGFloat) {
    println(parms)
}
public func trace(parms:UInt) {
    println(parms)
}
public func trace(parms:Double) {
    println(parms)
}