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
open class DisplayObjectContainer: InteractiveObject {
    internal var children:[DisplayObject] = []
    open var numChildren:UInt = 0
    
    /**
     Adds a child DisplayObject instance to this DisplayObjectContainer instance. The child is added to the front (top) of all other children in this DisplayObjectContainer instance. (To add a child to a specific index position, use the addChildAt() method.)
     
     If you add a child object that already has a different display object container as a parent, the object is removed from the child list of the other display object container.
     - Parameters:
     - child: The DisplayObject instance to add as a child of this DisplayObjectContainer instance.
     - Returns: The DisplayObject instance that you pass in the child parameter.
     */
    @discardableResult open func addChild(_ child:DisplayObject)->DisplayObject {
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
    /**
     Adds a child DisplayObject instance to this DisplayObjectContainer instance. The child is added at the index position specified. An index of 0 represents the back (bottom) of the display list for this DisplayObjectContainer object.
     
     For example, the following example shows three display objects, labeled a, b, and c, at index positions 0, 2, and 1, respectively:
     
     b over c over a
     
     If you add a child object that already has a different display object container as a parent, the object is removed from the child list of the other display object container.
     - Parameters:
     - child: The DisplayObject instance to add as a child of this DisplayObjectContainer instance.
     - index: The index position to which the child is added. If you specify a currently occupied index position, the child object that exists at that position and all higher positions are moved up one position in the child list.
     - Returns: The DisplayObject instance that you pass in the child parameter.
     */
    @discardableResult open func addChildAt(_ child:DisplayObject,_ index:UInt)->DisplayObject {
        return(addChildAt(child, index, dispatch:true))
    }
    @discardableResult fileprivate func addChildAt(_ child:DisplayObject,_ index:UInt, dispatch:Bool)->DisplayObject {
        if child.node.parent != nil {
            child.node.removeFromParent()
        }
        self.node.insertChild(child.node, at: Int(index))
        children.splice(index, deleteCount: 0, values: child)
        child.parent = self
        numChildren += 1
        if (dispatch) {
            child.dispatchEvent(Event(.Added))
        }
        return(child)
    }
    /**
     Determines whether the specified display object is a child of the DisplayObjectContainer instance or the instance itself. The search includes the entire display list including this DisplayObjectContainer instance. Grandchildren, great-grandchildren, and so on each return true.
     - Parameters:
     - child: The child object to test.
     - Returns: true if the child object is a child of the DisplayObjectContainer or the container itself; otherwise false.
     */
    open func contains(_ child:DisplayObject)->Bool {
        return (getChildIndex(child) > -1)
    }
    
    /**
     Returns the child display object instance that exists at the specified index.
     - Parameters:
     -index: The index position of the child object.
     - Returns: The child display object at the specified index position.
     */
    open func getChildAt(_ index:UInt)->DisplayObject? {
        return(children.get(Int(index)))
    }
    /**
     Returns the child display object that exists with the specified name. If more that one child display object has the specified name, the method returns the first object in the child list.
     The getChildAt() method is faster than the getChildByName() method. The getChildAt() method accesses a child from a cached array, whereas the getChildByName() method has to traverse a linked list to access a child.
     - Parameters:
     - name: The name of the child to return.
     - Returns: The child display object with the specified name.
     */
    open func getChildByName(_ name:String)->DisplayObject? {
        for child in children {
            if (child.name==name) {
                return child
            }
        }
        return nil
    }
    /**
     Returns the index position of a child DisplayObject instance.
     - Parameters:
     - child: The DisplayObject instance to identify.
     - Returns: The index position of the child display object to identify.
     */
    open func getChildIndex(_ child:DisplayObject)->Int {
        var index:Int = -1
        for i in 0..<Int(self.numChildren) {
            let t = self.getChildAt(UInt(i))
            if (t === child) {
                index = i
            }
        }
        return(index)
    }
    /**
     Removes the specified child DisplayObject instance from the child list of the DisplayObjectContainer instance. The parent property of the removed child is set to null. The index positions of any display objects above the child in the DisplayObjectContainer are decreased by 1.
     - Parameters:
     - child: The DisplayObject instance to remove.
     - Returns: The DisplayObject instance that you pass in the child parameter.
     */
    @discardableResult open func removeChild(_ child:DisplayObject)->DisplayObject {
        let index = getChildIndex(child)
        if index > -1  {
            self.node.removeChildren(in: [child.node])
            children.remove(at: index)
        }
        child.parent = nil
        child.dispatchEvent(Event(.Removed))
        return (child)
    }
    /**
     Removes a child DisplayObject from the specified index position in the child list of the DisplayObjectContainer. The parent property of the removed child is set to null. The index positions of any display objects above the child in the DisplayObjectContainer are decreased by 1.
     - Parameters:
     - index: The child index of the DisplayObject to remove.
     - Returns: The DisplayObject instance that was removed.
     */
    @discardableResult open func removeChildAt(_ index:UInt)->DisplayObject? {
        return(removeChildAt(index, dispatch: true))
    }
    @discardableResult fileprivate func removeChildAt(_ index:UInt, dispatch:Bool)->DisplayObject? {
        if let child = children.get(Int(index)) {
            self.node.removeChildren(in: [child.node])
            children.remove(at: Int(index))
            child.parent = nil
            if (dispatch) {
                child.dispatchEvent(Event(.Removed))
            }
            return (child)
        }
        return nil
    }
    /**
     Removes all child DisplayObject instances from the child list of the DisplayObjectContainer instance. The parent property of the removed children is set to null.
     - Parameters:
     - beginIndex: The beginning position.
     - endIndex: The ending position.
     */
    open func removeChildren(_ beginIndex:UInt=0,_ endIndex:UInt = UInt.max) {
        for i in beginIndex..<endIndex {
            removeChildAt(i)
        }
    }
    /**
     Changes the position of an existing child in the display object container. This affects the layering of child objects. For example, the following example shows three display objects, labeled a, b, and c, at index positions 0, 1, and 2, respectively:
     
     c over b over a
     
     When you use the setChildIndex() method and specify an index position that is already occupied, the only positions that change are those in between the display object's former and new position. All others will stay the same. If a child is moved to an index LOWER than its current index, all children in between will INCREASE by 1 for their index reference. If a child is moved to an index HIGHER than its current index, all children in between will DECREASE by 1 for their index reference. For example, if the display object container in the previous example is named container, you can swap the position of the display objects labeled a and b by calling the following code:
     
     container.setChildIndex(container.getChildAt(1), 0);
     This code results in the following arrangement of objects:
     
     c over a over b
     - Parameters:
     - child: The child DisplayObject instance for which you want to change the index number.
     */
    open func setChildIndex(_ child:DisplayObject,_ index:UInt) {
        addChildAt(child, index, dispatch:false)
    }
    
    /**
     Swaps the z-order (front-to-back order) of the two specified child objects. All other child objects in the display object container remain in the same index positions.
     - Parameters:
     - child1: The first child object.
     - child2: The second child object.
     */
    open func swapChildren(_ child1:DisplayObject,child2:DisplayObject) {
        let child1Index = getChildIndex(child1)
        let child2Index = getChildIndex(child2)
        if (child1Index > -1 && child2Index > -1) {
            swapChildrenAt(UInt(child1Index), UInt(child2Index))
        }
    }
    /**
     Swaps the z-order (front-to-back order) of the child objects at the two specified index positions in the child list. All other child objects in the display object container remain in the same index positions.
     - Parameters:
     - index1: The index position of the first child object.
     - index2: The index position of the second child object.
     */
    open func swapChildrenAt(_ index1:UInt,_ index2:UInt) {
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
    override internal func update(_ currentTime:CFTimeInterval) {
        super.update(currentTime)
        for child in children {
            child.update(currentTime)
        }
    }
}
