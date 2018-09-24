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
  /**
   Get an easing function with a curve and ease type.
   - parameter curve: Curve type
   - parameter easeType: Ease type
   */
  class func getEaseFunction(_ curve:CurveType, easeType:EaseType)->AHEasingFunction {
    var currentFunction:AHEasingFunction
    switch(curve) {
    case .curveTypeLinear:
      currentFunction=LinearInterpolation
    case .curveTypeQuadratic:
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
  /**
   Create a tween between two points.
   - parameter start: Start point
   - parameter end: End point
   - parameter time: duration of tween
   - parameter easingFunction: ease function - create an ease function with the getEaseFunction method.
   - parameter setterBlock: Any additional properties to tween.
   */
  class func createPointTween(_ start:CGPoint, end:CGPoint, time:TimeInterval,easingFunction:@escaping AHEasingFunction, setterBlock setter:@escaping ((SKNode,CGPoint)->Void))->SKAction {
    let action:SKAction = SKAction.customAction(withDuration: time, actionBlock: { (node:SKNode, elapsedTime:CGFloat) -> Void in
      let timeEq = easingFunction(Float(elapsedTime)/Float(time))
      let xValue:CGFloat = start.x + CGFloat(timeEq) * (end.x - start.x)
      let yValue:CGFloat = start.y + CGFloat(timeEq) * (end.y - start.y)
      setter(node,CGPoint(x: xValue, y: yValue))
    })
    return action
  }
  /**
   Create a tween between two values.
   - parameter start: Start value
   - parameter end: End value
   - parameter time: duration of tween
   - parameter easingFunction: ease function - create an ease function with the getEaseFunction method.
   - parameter setterBlock: Any additional properties to tween.
   */
  class func createFloatTween(_ start:CGFloat, end:CGFloat, time:TimeInterval,easingFunction:@escaping AHEasingFunction, setterBlock setter:@escaping ((SKNode,CGFloat)->Void))->SKAction {
    let action:SKAction = SKAction.customAction(withDuration: time, actionBlock: { (node:SKNode, elapsedTime:CGFloat) -> Void in
      let timeEq = easingFunction(Float(elapsedTime)/Float(time))
      let value:CGFloat = start+CGFloat(timeEq) * (end-start)
      setter(node,value)
    })
    return action
  }
  /**
   Create a tween between two colors.
   - parameter start: Start color
   - parameter end: End color
   - parameter time: duration of tween
   - parameter easingFunction: ease function - create an ease function with the getEaseFunction method.
   - parameter setterBlock: Any additional properties to tween.
   */
  class func createColorTween(_ start:UIColor, end:UIColor, time:TimeInterval,easingFunction:@escaping AHEasingFunction, setterBlock setter:@escaping ((SKNode,UIColor)->Void))->SKAction {
    
    var startRed:CGFloat = 0, startGreen:CGFloat = 0,startBlue:CGFloat = 0,startAlpha:CGFloat = 0
    start.getRed(&startRed, green: &startGreen, blue: &startBlue, alpha: &startAlpha)
    var endRed:CGFloat = 0, endGreen:CGFloat = 0,endBlue:CGFloat = 0,endAlpha:CGFloat = 0
    end.getRed(&endRed, green: &endGreen, blue: &endBlue, alpha: &endAlpha)
    
    let action:SKAction = SKAction.customAction(withDuration: time, actionBlock: { (node:SKNode, elapsedTime:CGFloat) -> Void in
      let timeEq = easingFunction(Float(elapsedTime)/Float(time))
      
      let redValue:CGFloat = startRed + CGFloat(timeEq) * (endRed - startRed)
      let greenValue:CGFloat = startGreen + CGFloat(timeEq) * (endGreen - startGreen)
      let blueValue:CGFloat = startBlue + CGFloat(timeEq) * (endBlue - startBlue)
      let alphaValue:CGFloat = startAlpha + CGFloat(timeEq) * (endAlpha - startAlpha)
      
      let color = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: alphaValue)
      setter(node,color)
    })
    return action
  }
  //MARK: Color
  /**
   Animate label color
   - parameter easeFunction: Curve type
   - parameter easeType: Ease type
   - parameter time: duration of tween
   - parameter from: initial color
   - parameter to: destination color
   */
  class func tweenLabelColor(easeFunction curve:CurveType, easeType:EaseType, time:TimeInterval, from:UIColor, to:UIColor)->SKAction {
    let easingFunction = SKEase.getEaseFunction(curve, easeType: easeType)
    let action = self.createColorTween(from, end: to, time: time, easingFunction: easingFunction) { (node:SKNode, color:UIColor) -> Void in
      if let node = node as? SKLabelNode {
        node.fontColor = color
      }
    }
    return action
  }
  //MARK: Color
  /**
   Animate shape fill color
   - parameter easeFunction: Curve type
   - parameter easeType: Ease type
   - parameter time: duration of tween
   - parameter from: initial color
   - parameter to: destination color
   */
  class func tweenShapeFillColor(easeFunction curve:CurveType, easeType:EaseType, time:TimeInterval, from:UIColor, to:UIColor)->SKAction {
    let easingFunction = SKEase.getEaseFunction(curve, easeType: easeType)
    let action = self.createColorTween(from, end: to, time: time, easingFunction: easingFunction) { (node:SKNode, color:UIColor) -> Void in
      if let node = node as? SKShapeNode {
        node.fillColor = color
      }
    }
    return action
  }
  //MARK: Move
  /**
   Animate x/y movement
   - parameter easeFunction: Curve type
   - parameter easeType: Ease type
   - parameter time: duration of tween
   - parameter from: initial point
   - parameter to: destination point
   */
  class func move(easeFunction curve:CurveType, easeType:EaseType, time:TimeInterval, from:CGPoint, to:CGPoint)->SKAction {
    let easingFunction = SKEase.getEaseFunction(curve, easeType: easeType)
    let action = self.createPointTween(from, end: to, time: time, easingFunction: easingFunction) { (node:SKNode, point:CGPoint) -> Void in
      node.position = point
    }
    return action
  }
  ///legacy
  class func moveToWithNode(_ target:SKNode, easeFunction curve:CurveType, easeType:EaseType, time:TimeInterval, to:CGPoint)->SKAction {
    let easingFunction = SKEase.getEaseFunction(curve, easeType: easeType)
    let startPosition = target.position
    let action = self.createPointTween(CGPoint(x: startPosition.x,y: startPosition.y), end: to, time: time, easingFunction: easingFunction) { (node:SKNode, point:CGPoint) -> Void in
      node.position = point
    }
    return action
  }
  ///legacy
  class func moveFromWithNode(_ target:SKNode, easeFunction curve:CurveType, easeType:EaseType, time:TimeInterval, from:CGPoint)->SKAction {
    let easingFunction = SKEase.getEaseFunction(curve, easeType: easeType)
    let startPosition = target.position
    let action = self.createPointTween(from, end: CGPoint(x: startPosition.x,y: startPosition.y), time: time, easingFunction: easingFunction) { (node:SKNode, point:CGPoint) -> Void in
      node.position = point
    }
    return action
  }
  
  //MARK: Scale
  /**
   Animate scale
   - parameter easeFunction: Curve type
   - parameter easeType: Ease type
   - parameter time: duration of tween
   - parameter from: initial scale
   - parameter to: destination scale
   */
  class func scale(easeFunction curve:CurveType, easeType:EaseType, time:TimeInterval, from:CGFloat, to:CGFloat)->SKAction {
    let easingFunction = SKEase.getEaseFunction(curve, easeType: easeType)
    let action = self.createFloatTween(from, end: to, time: time, easingFunction: easingFunction) { (node:SKNode, scale:CGFloat) -> Void in
      node.setScale(scale)
    }
    return action
  }
  /**
   Animate scale X
   - parameter easeFunction: Curve type
   - parameter easeType: Ease type
   - parameter time: duration of tween
   - parameter from: initial scale X
   - parameter to: destination scale X
   */
  class func scaleX(easeFunction curve:CurveType, easeType:EaseType, time:TimeInterval, from:CGFloat, to:CGFloat)->SKAction {
    let easingFunction = SKEase.getEaseFunction(curve, easeType: easeType)
    let action = self.createFloatTween(from, end: to, time: time, easingFunction: easingFunction) { (node:SKNode, scale:CGFloat) -> Void in
      node.xScale = scale
    }
    return action
  }
  /**
   Animate scale Y
   - parameter easeFunction: Curve type
   - parameter easeType: Ease type
   - parameter time: duration of tween
   - parameter from: initial scale Y
   - parameter to: destination scale Y
   */
  class func scaleY(easeFunction curve:CurveType, easeType:EaseType, time:TimeInterval, from:CGFloat, to:CGFloat)->SKAction {
    let easingFunction = SKEase.getEaseFunction(curve, easeType: easeType)
    let action = self.createFloatTween(from, end: to, time: time, easingFunction: easingFunction) { (node:SKNode, scale:CGFloat) -> Void in
      node.yScale = scale
    }
    return action
  }
  ///legacy
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
  
  //MARK: Rotate
  /**
   Animate z rotation
   - parameter easeFunction: Curve type
   - parameter easeType: Ease type
   - parameter time: duration of tween
   - parameter from: initial z rotation
   - parameter to: destination z rotation
   */
  class func rotate(easeFunction curve:CurveType, easeType:EaseType, time:TimeInterval, from:CGFloat, to:CGFloat)->SKAction {
    let easingFunction = SKEase.getEaseFunction(curve, easeType: easeType)
    let action = self.createFloatTween(from, end: to, time: time, easingFunction: easingFunction) { (node:SKNode, rotation:CGFloat) -> Void in
      node.zRotation=rotation
    }
    return action
  }
  ///legacy
  class func rotateToWithNode(_ target:SKNode, easeFunction curve:CurveType, easeType:EaseType, time:TimeInterval, toValue to:CGFloat)->SKAction {
    let easingFunction = SKEase.getEaseFunction(curve, easeType: easeType)
    let action = self.createFloatTween(target.zRotation, end: to, time: time, easingFunction: easingFunction) { (node:SKNode, rotation:CGFloat) -> Void in
      node.zRotation=rotation
    }
    return action
  }
  class func rotateFromWithNode(_ target:SKNode, easeFunction curve:CurveType, easeType:EaseType, time:TimeInterval, fromValue from:CGFloat)->SKAction {
    let easingFunction = SKEase.getEaseFunction(curve, easeType: easeType)
    let action = self.createFloatTween(from, end: target.zRotation, time: time, easingFunction: easingFunction) { (node:SKNode, rotation:CGFloat) -> Void in
      node.zRotation=rotation
    }
    return action
  }
  
  
  //MARK: Fade
  /**
   Animate alpha
   - parameter easeFunction: Curve type
   - parameter easeType: Ease type
   - parameter time: duration of tween
   - parameter from: initial alpha
   - parameter to: destination alpha
   */
  class func fade(easeFunction curve:CurveType, easeType:EaseType, time:TimeInterval, fromValue from:CGFloat, toValue to:CGFloat)->SKAction {
    let easingFunction = SKEase.getEaseFunction(curve, easeType: easeType)
    let action = self.createFloatTween(from, end: to, time: time, easingFunction: easingFunction) { (node:SKNode, alpha:CGFloat) -> Void in
      node.alpha=alpha
    }
    return action
  }
  ///legacy
  class func fadeToWithNode(_ target:SKNode, easeFunction curve:CurveType, easeType:EaseType, time:TimeInterval, toValue to:CGFloat)->SKAction {
    let easingFunction = SKEase.getEaseFunction(curve, easeType: easeType)
    let action = self.createFloatTween(target.alpha, end: to, time: time, easingFunction: easingFunction) { (node:SKNode, alpha:CGFloat) -> Void in
      node.alpha=alpha
    }
    return action
  }
  ///legacy
  class func fadeFromWithNode(_ target:SKNode, easeFunction curve:CurveType, easeType:EaseType, time:TimeInterval, fromValue from:CGFloat)->SKAction {
    let easingFunction = SKEase.getEaseFunction(curve, easeType: easeType)
    let action = self.createFloatTween(from, end: target.alpha, time: time, easingFunction: easingFunction) { (node:SKNode, alpha:CGFloat) -> Void in
      node.alpha=alpha
    }
    return action
  }
}
