//
//  MyDrawView.swift
//  LiveViewDemo
//
//  Created by Craig on 5/05/2015.
//  Copyright (c) 2015 Interactive Coconut. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable
class MyDrawView: UIView {
    
    
    @IBInspectable var startColor: UIColor = UIColor.whiteColor()
    @IBInspectable var endColor:UIColor = UIColor.redColor()
    @IBInspectable var endRadius:CGFloat = 200
    
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        var colorspace = CGColorSpaceCreateDeviceRGB()
        var locations: [CGFloat] = [ 0.0, 1.0]
        var gradient = CGGradientCreateWithColors(colorspace, [startColor.CGColor, endColor.CGColor], locations)
        var startPoint = CGPoint()
        var endPoint = CGPoint()
        var startRadius: CGFloat = 0
        startPoint.x = 210
        startPoint.y = 180
        endPoint.x = 210
        endPoint.y = 200
        CGContextDrawRadialGradient(context, gradient, startPoint, startRadius, endPoint, endRadius, 0)
        
    }
    
    
}
