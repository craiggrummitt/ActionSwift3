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
    /**
     A non-negative integer specifying the number of elements in the array. This property is automatically updated when new elements are added to the array. When you assign a value to an array element (for example, my_array[index] = value), if index is a number, and index+1 is greater than the length property, the length property is updated to index+1.
     */
    var length:Int {
        return self.count
    }
    func indexOf<T : Equatable>(_ x:T) -> Int {
        for i in 0..<self.length {
            if self[i] as? T == x {
                return i
            }
        }
        return -1
    }
    func contains<T>(_ obj: T) -> Bool where T : Equatable {
        return self.filter({$0 as? T == obj}).count > 0
    }
    /**
     Checks if an index is safe
     - Parameters:
     -  index: Index to check.
     - Returns: Boolean indicating if index is safe.
     */
    func contains(_ index: Int) -> Bool {
        if 0 <= index && index < count {
            return true
        } else {
            return false
        }
    }
    /** 
     Safely lookup an index that might be out of bounds, returning nil if it does not exist
     - Parameters:
     -  index: Index to check.
     - Returns: The Element at that index.
     */
    func get(_ index: Int) -> Element? {
        if 0 <= index && index < count {
            return self[index]
        } else {
            return nil
        }
    }
    /**
     Adds an element to the end of an array.
     - Parameters:
     - newElement: One value to append to the array.
     */
    mutating func push(_ newElement: Element) {
        self.append(newElement)
    }
    
    /**
     Removes the last element from an array and returns the value of that element.
     - Returns: The value of the last element (of any data type) in the specified array.
     */
    mutating func pop()->Element? {
        let last = self.last
        if let last = last {
            self.removeLast()
            return last
        }
        return nil
    }
    /**
     Adds elements to and removes elements from an array. 
     - Parameters:
        - startIndex: An integer that specifies the index of the element in the array where the insertion or deletion begins. 
        - deleteCount: An integer that specifies the number of elements to be deleted. This number includes the element specified in the startIndex parameter.
        - values: An optional list of one or more comma-separated values to insert into the array at the position specified in the startIndex parameter.
     - Returns: An array containing the elements that were removed from the original array.
     */
    @discardableResult mutating func splice(_ startIndex:UInt,deleteCount:UInt, values:[Element])->Array {
        let range = Int(startIndex)..<Int(startIndex + deleteCount)
        let returnArray = Array(self[range])
        self.removeSubrange(range)
        self.insert(contentsOf: values, at: Int(startIndex))
        return returnArray
    }
    /**
     Adds elements to and removes elements from an array.
     - Parameters:
     - startIndex: An integer that specifies the index of the element in the array where the insertion or deletion begins.
     - deleteCount: An integer that specifies the number of elements to be deleted. This number includes the element specified in the startIndex parameter.
     - values: A value to insert into the array at the position specified in the startIndex parameter.
     - Returns: An array containing the elements that were removed from the original array.
     */
    @discardableResult mutating func splice(_ startIndex:UInt,deleteCount:UInt, values:Element)->Array {
        return splice(startIndex, deleteCount: deleteCount, values: [values])
    }
}
