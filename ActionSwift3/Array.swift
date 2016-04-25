//
//  Array.swift
//  ActionSwiftSK
//
//  Created by Craig on 5/05/2015.
//  Copyright (c) 2015 Interactive Coconut. All rights reserved.
//
// Unfortunately extensions in frameworks can't be made public, at least for now - watch this space...
//
import Foundation

/**
Includes AS3 versions of Array methods
*/
extension Array {
    var length:Int {
        return self.count
    }
    func indexOf<T : Equatable>(x:T) -> Int {
        for i in 0..<self.length {
            if self[i] as? T == x {
                return i
            }
        }
        return -1
    }
    func contains<T where T : Equatable>(obj: T) -> Bool {
        return self.filter({$0 as? T == obj}).count > 0
    }
    // Check index is safe
    func contains(index: Int) -> Bool {
        if 0 <= index && index < count {
            return true
        } else {
            return false
        }
    }
    // Safely lookup an index that might be out of bounds,
    // returning nil if it does not exist
    func get(index: Int) -> Element? {
        if 0 <= index && index < count {
            return self[index]
        } else {
            return nil
        }
    }
    mutating func push(newElement: Element) {
        self.append(newElement)
    }
    mutating func pop()->Element? {
        let last = self.last
        if let last = last {
            self.removeLast()
            return last
        }
        return nil
    }
    mutating func splice(startIndex:UInt,deleteCount:UInt, values:[Element])->Array {
        var returnArray = self
        returnArray.removeRange(Int(startIndex)..<Int(startIndex + deleteCount))
        returnArray.insertContentsOf(values, at: Int(startIndex))
        return returnArray
    }
    mutating func splice(startIndex:UInt,deleteCount:UInt, values:Element)->Array {
        return splice(startIndex, deleteCount: deleteCount, values: [values])
    }
}