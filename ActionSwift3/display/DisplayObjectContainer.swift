//
//  DisplayObjectContainer.swift
//  ActionSwiftSK
//
//  Created by Craig on 5/05/2015.
//  Copyright (c) 2015 Interactive Coconut. All rights reserved.
//

import UIKit

/**
A DisplayObjectContainer can contain DisplayObjects, using `addChild`, `addChildAt`, `getChildAt`, `removeChildAt`, etc.
*/
public class DisplayObjectContainer: InteractiveObject {
    internal var children:[DisplayObject] = []
    public var numChildren:UInt = 0
    
    public func addChild(child:DisplayObject)->DisplayObject {
        if child.node.parent != nil {
            child.node.removeFromParent()
        }
        child.stage = self.stage
        self.node.addChild(child.node)
        children.push(child)
        child.parent = self
        numChildren += 1
        
        child.dispatchEvent(Event(.Added))
        return(child)
    }
    public func addChildAt(child:DisplayObject,_ index:UInt)->DisplayObject {
        return(addChildAt(child, index, dispatch:true))
    }
    private func addChildAt(child:DisplayObject,_ index:UInt, dispatch:Bool)->DisplayObject {
        if child.node.parent != nil {
            child.node.removeFromParent()
        }
        self.node.insertChild(child.node, atIndex: Int(index))
        children.splice(index, deleteCount: 0, values: child)
        child.parent = self
        numChildren += 1
        if (dispatch) {
            child.dispatchEvent(Event(.Added))
        }
        return(child)
    }
    public func contains(child:DisplayObject)->Bool {
        return (getChildIndex(child) > -1)
    }
    public func getChildAt(index:UInt)->DisplayObject? {
        return(children.get(Int(index)))
    }
    public func getChildByName(name:String)->DisplayObject? {
        for child in children {
            if (child.name==name) {
                return child
            }
        }
        return nil
    }
    public func getChildIndex(child:DisplayObject)->Int {
        var index:Int = -1
        for i in 0..<Int(self.numChildren) {
            let t = self.getChildAt(UInt(i))
            if (t === child) {
                index = i
            }
        }
        return(index)
    }
    public func removeChild(child:DisplayObject)->DisplayObject {
        let index = getChildIndex(child)
        if index > -1  {
            self.node.removeChildrenInArray([child.node])
            children.removeAtIndex(index)
        }
        child.parent = nil
        child.dispatchEvent(Event(.Removed))
        return (child)
    }
    
    public func removeChildAt(index:UInt)->DisplayObject? {
        return(removeChildAt(index, dispatch: true))
    }
    private func removeChildAt(index:UInt, dispatch:Bool)->DisplayObject? {
        if let child = children.get(Int(index)) {
            self.node.removeChildrenInArray([child.node])
            children.removeAtIndex(Int(index))
            child.parent = nil
            if (dispatch) {
                child.dispatchEvent(Event(.Removed))
            }
            return (child)
        }
        return nil
    }
    public func removeChildren(beginIndex:UInt=0,_ endIndex:UInt = UInt.max) {
        for i in beginIndex..<endIndex {
            removeChildAt(i)
        }
    }
    public func setChildIndex(child:DisplayObject,_ index:UInt) {
        addChildAt(child, index, dispatch:false)
    }
    public func swapChildren(child1:DisplayObject,child2:DisplayObject) {
        let child1Index = getChildIndex(child1)
        let child2Index = getChildIndex(child2)
        if (child1Index > -1 && child2Index > -1) {
            swapChildrenAt(UInt(child1Index), UInt(child2Index))
        }
    }
    public func swapChildrenAt(index1:UInt,_ index2:UInt) {
        if (index1>index2) {
            let child1 = removeChildAt(index1, dispatch: false)
            let child2 = removeChildAt(index2, dispatch: false)
            if let child1 = child1 {
                addChildAt(child1, index1, dispatch: false)
            }
            if let child2 = child2 {
                addChildAt(child2, index2, dispatch: false)
            }
        }
    }
    override internal func update(currentTime:CFTimeInterval) {
        super.update(currentTime)
        for child in children {
            child.update(currentTime)
        }
    }
}
