//
//  EventHandler.swift
//  ActionSwiftSK
//
//  Created by Craig on 5/05/2015.
//  Copyright (c) 2015 Interactive Coconut. All rights reserved.
//

import UIKit
/**
    Since funcs can not be tested for equality in Swift, this wrapper class is used with a function name
    to test for equality.
    http://stackoverflow.com/questions/24111984/how-do-you-test-functions-and-closures-for-equality
    https://devforums.apple.com/message/1035180#1035180
*/
public class EventHandler: Object {
    var function:(Event)->Void
    var functionName:String
    public init(_ function:(Event)->Void,_ functionName:String) {
        self.function = function
        self.functionName = functionName
    }
}
