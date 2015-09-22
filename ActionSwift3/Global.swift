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
    print(parms)
}
public func trace(parms:Int) {
    print(parms)
}
public func trace(parms:CGFloat) {
    print(parms)
}
public func trace(parms:UInt) {
    print(parms)
}
public func trace(parms:Double) {
    print(parms)
}

///The return of AS3 data types
public typealias Boolean = Bool
//Trying to keep this codebase agnostic, regardless of some weird idiosyncronacies of the original datatypes, such as AS3 `int` not following correct case conventions!
public typealias int = Int
public typealias Number = CGFloat

