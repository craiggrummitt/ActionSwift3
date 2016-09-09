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
    class func getEaseFunction(_ curve:CurveType, easeType:EaseType)->AHEasingFunction {
        let currentFunction:AHEasingFunction
        switch(curve) {
        case .curveTypeLinear:
            currentFunction=LinearInterpolation
        case .curveTypeQuadratic:
            if (easeType == EaseType.easeTypeIn) {print("YES")}
            currentFunction = (easeType == .easeTypeIn) ? QuadraticEaseIn : (easeType == .easeTypeOut) ? QuadraticEaseOut : QuadraticEaseInOut;
        case .curveTypeCubic:
            currentFunction = (easeType == .easeTypeIn) ? CubicEaseIn : (easeType == .easeTypeOut) ? CubicEaseOut : CubicEaseInOut;
        case .curveTypeQuartic:
            currentFunction = (easeType == .easeTypeIn) ? QuarticEaseIn : (easeType == .easeTypeOut) ? QuarticEaseOut : QuarticEaseInOut;
        case .curveTypeQuintic:
            currentFunction = (easeType == .easeTypeIn) ? QuinticEaseIn : (easeType == .easeTypeOut) ? QuinticEaseOut : QuinticEaseInOut;
        case .curveTypeSine:
            currentFunction = (easeType == .easeTypeIn) ? SineEaseIn : (easeType == .easeTypeOut) ? SineEaseOut : SineEaseInOut;
        case .curveTypeCircular:
            currentFunction = (easeType == .easeTypeIn) ? CircularEaseIn : (easeType == .easeTypeOut) ? CircularEaseOut : CircularEaseInOut;
        case .curveTypeExpo:
            currentFunction = (easeType == .easeTypeIn) ? ExponentialEaseIn : (easeType == .easeTypeOut) ? ExponentialEaseOut : ExponentialEaseInOut;
        case .curveTypeElastic:
            currentFunction = (easeType == .easeTypeIn) ? ElasticEaseIn : (easeType == .easeTypeOut) ? ElasticEaseOut : ElasticEaseInOut;
        case .curveTypeBack:
            currentFunction = (easeType == .easeTypeIn) ? BackEaseIn : (easeType == .easeTypeOut) ? BackEaseOut : BackEaseInOut;
        case .curveTypeBounce:
            currentFunction = (easeType == .easeTypeIn) ? BounceEaseIn : (easeType == .easeTypeOut) ? BounceEaseOut : BounceEaseInOut;
        }
        return currentFunction
    }
    class func createPointTween(_ start:CGVector, end:CGVector, time:TimeInterval,easingFunction:AHEasingFunction, setterBlock setter:((SKNode,CGPoint)->Void))->SKAction {
        let action:SKAction = SKAction.customAction(withDuration: time, actionBlock: { (node:SKNode!, elapsedTime:CGFloat) -> Void in
            let timeEq = easingFunction(Float(elapsedTime)/Float(time))
            let xValue:CGFloat = start.dx + CGFloat(timeEq) * (end.dx - start.dx)
            let yValue:CGFloat = start.dy + CGFloat(timeEq) * (end.dy - start.dy)
            setter(node,CGPoint(x: xValue, y: yValue))
        })
        return action
    }
    class func createFloatTween(_ start:CGFloat, end:CGFloat, time:TimeInterval,easingFunction:AHEasingFunction, setterBlock setter:((SKNode,CGFloat)->Void))->SKAction {
        let action:SKAction = SKAction.customAction(withDuration: time, actionBlock: { (node:SKNode!, elapsedTime:CGFloat) -> Void in
            let timeEq = easingFunction(Float(elapsedTime)/Float(time))
            let value:CGFloat = start+CGFloat(timeEq) * (end-start)
            setter(node,value)
        })
        return action
    }
    class func moveToWithNode(_ target:SKNode, easeFunction curve:CurveType, easeType:EaseType, time:TimeInterval, toVector to:CGVector)->SKAction {
        let easingFunction = SKEase.getEaseFunction(curve, easeType: easeType)
        let startPosition = target.position
        let action = self.createPointTween(CGVector(dx: startPosition.x,dy: startPosition.y), end: to, time: time, easingFunction: easingFunction) { (node:SKNode, point:CGPoint) -> Void in
            node.position = point
        }
        return action
    }
    
    class func moveFromWithNode(_ target:SKNode, easeFunction curve:CurveType, easeType:EaseType, time:TimeInterval, fromVector from:CGVector)->SKAction {
        let easingFunction = SKEase.getEaseFunction(curve, easeType: easeType)
        let startPosition = target.position
        let action = self.createPointTween(from, end: CGVector(dx: startPosition.x,dy: startPosition.y), time: time, easingFunction: easingFunction) { (node:SKNode, point:CGPoint) -> Void in
            node.position = point
        }
        return action
    }
    class func scaleToWithNode(_ target:SKNode, easeFunction curve:CurveType, easeType:EaseType, time:TimeInterval, toValue to:CGFloat)->SKAction {
        let easingFunction = SKEase.getEaseFunction(curve, easeType: easeType)
        let action = self.createFloatTween(target.xScale, end: to, time: time, easingFunction: easingFunction) { (node:SKNode, scale:CGFloat) -> Void in
            node.setScale(scale)
        }
        return action
    }
    class func scaleFromWithNode(_ target:SKNode, easeFunction curve:CurveType, easeType:EaseType, time:TimeInterval, fromValue from:CGFloat)->SKAction {
        let easingFunction = SKEase.getEaseFunction(curve, easeType: easeType)
        let action = self.createFloatTween(from, end: target.xScale, time: time, easingFunction: easingFunction) { (node:SKNode, scale:CGFloat) -> Void in
            node.setScale(scale)
        }
        return action
    }
    class func rotateToWithNode(_ target:SKNode, easeFunction curve:CurveType, easeType:EaseType, time:TimeInterval, toValue to:CGFloat)->SKAction {
        let easingFunction = SKEase.getEaseFunction(curve, easeType: easeType)
        let action = self.createFloatTween(target.zRotation, end: to, time: time, easingFunction: easingFunction) { (node:SKNode, rotation) -> Void in
            node.zRotation=rotation
        }
        return action
    }
    class func rotateFromWithNode(_ target:SKNode, easeFunction curve:CurveType, easeType:EaseType, time:TimeInterval, fromValue from:CGFloat)->SKAction {
        let easingFunction = SKEase.getEaseFunction(curve, easeType: easeType)
        let action = self.createFloatTween(from, end: target.zRotation, time: time, easingFunction: easingFunction) { (node:SKNode,  rotation) -> Void in
            node.zRotation=rotation
        }
        return action
    }
    class func fadeToWithNode(_ target:SKNode, easeFunction curve:CurveType, easeType:EaseType, time:TimeInterval, toValue to:CGFloat)->SKAction {
        let easingFunction = SKEase.getEaseFunction(curve, easeType: easeType)
        let action = self.createFloatTween(target.alpha, end: to, time: time, easingFunction: easingFunction) { (node:SKNode, alpha:CGFloat) -> Void in
            node.alpha=alpha
        }
        return action
    }
    class func fadeFromWithNode(_ target:SKNode, easeFunction curve:CurveType, easeType:EaseType, time:TimeInterval, fromValue from:CGFloat)->SKAction {
        let easingFunction = SKEase.getEaseFunction(curve, easeType: easeType)
        let action = self.createFloatTween(from, end: target.alpha, time: time, easingFunction: easingFunction) { (node:SKNode, alpha:CGFloat) -> Void in
            node.alpha=alpha
        }
        return action
    }
}
