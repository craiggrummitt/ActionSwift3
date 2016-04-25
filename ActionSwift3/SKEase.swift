//
//  SKEase.swift
//
//  Created by CraigGrummitt on 6/08/2014.
//  Copyright (c) 2014 CraigGrummitt. All rights reserved.
//
//  Based on SpriteKit_Easing.m
//  SpriteKit-Easing
//
//  Created by Andrew Eiche on 10/20/13.
//  Copyright (c) 2013 Birdcage Games LLC. All rights reserved.
//
import Foundation
import UIKit
import SpriteKit

class SKEase {
    class func getEaseFunction(curve:CurveType, easeType:EaseType)->AHEasingFunction {
        let currentFunction:AHEasingFunction
        switch(curve) {
        case .CurveTypeLinear:
            currentFunction=LinearInterpolation
        case .CurveTypeQuadratic:
            if (easeType == EaseType.EaseTypeIn) {print("YES")}
            currentFunction = (easeType == .EaseTypeIn) ? QuadraticEaseIn : (easeType == .EaseTypeOut) ? QuadraticEaseOut : QuadraticEaseInOut;
        case .CurveTypeCubic:
            currentFunction = (easeType == .EaseTypeIn) ? CubicEaseIn : (easeType == .EaseTypeOut) ? CubicEaseOut : CubicEaseInOut;
        case .CurveTypeQuartic:
            currentFunction = (easeType == .EaseTypeIn) ? QuarticEaseIn : (easeType == .EaseTypeOut) ? QuarticEaseOut : QuarticEaseInOut;
        case .CurveTypeQuintic:
            currentFunction = (easeType == .EaseTypeIn) ? QuinticEaseIn : (easeType == .EaseTypeOut) ? QuinticEaseOut : QuinticEaseInOut;
        case .CurveTypeSine:
            currentFunction = (easeType == .EaseTypeIn) ? SineEaseIn : (easeType == .EaseTypeOut) ? SineEaseOut : SineEaseInOut;
        case .CurveTypeCircular:
            currentFunction = (easeType == .EaseTypeIn) ? CircularEaseIn : (easeType == .EaseTypeOut) ? CircularEaseOut : CircularEaseInOut;
        case .CurveTypeExpo:
            currentFunction = (easeType == .EaseTypeIn) ? ExponentialEaseIn : (easeType == .EaseTypeOut) ? ExponentialEaseOut : ExponentialEaseInOut;
        case .CurveTypeElastic:
            currentFunction = (easeType == .EaseTypeIn) ? ElasticEaseIn : (easeType == .EaseTypeOut) ? ElasticEaseOut : ElasticEaseInOut;
        case .CurveTypeBack:
            currentFunction = (easeType == .EaseTypeIn) ? BackEaseIn : (easeType == .EaseTypeOut) ? BackEaseOut : BackEaseInOut;
        case .CurveTypeBounce:
            currentFunction = (easeType == .EaseTypeIn) ? BounceEaseIn : (easeType == .EaseTypeOut) ? BounceEaseOut : BounceEaseInOut;
        }
        return currentFunction
    }
    class func createPointTween(start:CGVector, end:CGVector, time:NSTimeInterval,easingFunction:AHEasingFunction, setterBlock setter:((SKNode,CGPoint)->Void))->SKAction {
        let action:SKAction = SKAction.customActionWithDuration(time, actionBlock: { (node:SKNode!, elapsedTime:CGFloat) -> Void in
            let timeEq = easingFunction(Float(elapsedTime)/Float(time))
            let xValue:CGFloat = start.dx + CGFloat(timeEq) * (end.dx - start.dx)
            let yValue:CGFloat = start.dy + CGFloat(timeEq) * (end.dy - start.dy)
            setter(node,CGPointMake(xValue, yValue))
        })
        return action
    }
    class func createFloatTween(start:CGFloat, end:CGFloat, time:NSTimeInterval,easingFunction:AHEasingFunction, setterBlock setter:((SKNode,CGFloat)->Void))->SKAction {
        let action:SKAction = SKAction.customActionWithDuration(time, actionBlock: { (node:SKNode!, elapsedTime:CGFloat) -> Void in
            let timeEq = easingFunction(Float(elapsedTime)/Float(time))
            let value:CGFloat = start+CGFloat(timeEq) * (end-start)
            setter(node,value)
        })
        return action
    }
    class func moveToWithNode(target:SKNode, easeFunction curve:CurveType, easeType:EaseType, time:NSTimeInterval, toVector to:CGVector)->SKAction {
        let easingFunction = SKEase.getEaseFunction(curve, easeType: easeType)
        let startPosition = target.position
        let action = self.createPointTween(CGVectorMake(startPosition.x,startPosition.y), end: to, time: time, easingFunction: easingFunction) { (node:SKNode, point:CGPoint) -> Void in
            node.position = point
        }
        return action
    }
    
    class func moveFromWithNode(target:SKNode, easeFunction curve:CurveType, easeType:EaseType, time:NSTimeInterval, fromVector from:CGVector)->SKAction {
        let easingFunction = SKEase.getEaseFunction(curve, easeType: easeType)
        let startPosition = target.position
        let action = self.createPointTween(from, end: CGVectorMake(startPosition.x,startPosition.y), time: time, easingFunction: easingFunction) { (node:SKNode, point:CGPoint) -> Void in
            node.position = point
        }
        return action
    }
    class func scaleToWithNode(target:SKNode, easeFunction curve:CurveType, easeType:EaseType, time:NSTimeInterval, toValue to:CGFloat)->SKAction {
        let easingFunction = SKEase.getEaseFunction(curve, easeType: easeType)
        let action = self.createFloatTween(target.xScale, end: to, time: time, easingFunction: easingFunction) { (node:SKNode, scale:CGFloat) -> Void in
            node.setScale(scale)
        }
        return action
    }
    class func scaleFromWithNode(target:SKNode, easeFunction curve:CurveType, easeType:EaseType, time:NSTimeInterval, fromValue from:CGFloat)->SKAction {
        let easingFunction = SKEase.getEaseFunction(curve, easeType: easeType)
        let action = self.createFloatTween(from, end: target.xScale, time: time, easingFunction: easingFunction) { (node:SKNode, scale:CGFloat) -> Void in
            node.setScale(scale)
        }
        return action
    }
    class func rotateToWithNode(target:SKNode, easeFunction curve:CurveType, easeType:EaseType, time:NSTimeInterval, toValue to:CGFloat)->SKAction {
        let easingFunction = SKEase.getEaseFunction(curve, easeType: easeType)
        let action = self.createFloatTween(target.zRotation, end: to, time: time, easingFunction: easingFunction) { (node:SKNode, rotation) -> Void in
            node.zRotation=rotation
        }
        return action
    }
    class func rotateFromWithNode(target:SKNode, easeFunction curve:CurveType, easeType:EaseType, time:NSTimeInterval, fromValue from:CGFloat)->SKAction {
        let easingFunction = SKEase.getEaseFunction(curve, easeType: easeType)
        let action = self.createFloatTween(from, end: target.zRotation, time: time, easingFunction: easingFunction) { (node:SKNode,  rotation) -> Void in
            node.zRotation=rotation
        }
        return action
    }
    class func fadeToWithNode(target:SKNode, easeFunction curve:CurveType, easeType:EaseType, time:NSTimeInterval, toValue to:CGFloat)->SKAction {
        let easingFunction = SKEase.getEaseFunction(curve, easeType: easeType)
        let action = self.createFloatTween(target.alpha, end: to, time: time, easingFunction: easingFunction) { (node:SKNode, alpha:CGFloat) -> Void in
            node.alpha=alpha
        }
        return action
    }
    class func fadeFromWithNode(target:SKNode, easeFunction curve:CurveType, easeType:EaseType, time:NSTimeInterval, fromValue from:CGFloat)->SKAction {
        let easingFunction = SKEase.getEaseFunction(curve, easeType: easeType)
        let action = self.createFloatTween(from, end: target.alpha, time: time, easingFunction: easingFunction) { (node:SKNode, alpha:CGFloat) -> Void in
            node.alpha=alpha
        }
        return action
    }
}
