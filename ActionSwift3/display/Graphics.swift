//
//  Graphics.swift
//  ActionSwiftSK
//
//  Created by Craig on 6/05/2015.
//  Copyright (c) 2015 Interactive Coconut. All rights reserved.
//

import SpriteKit

/**
A Graphics class can be used to display shapes. First call `beginFill` if you want a fill color and call `lineStyle` to set the line style.
Then you can draw a circle, elipse, rectangle or triangle.
*/
public class Graphics: Object {
    var node = SKNode()
    var fillColor = UIColor.blackColor()
    var lineColor = UIColor.blackColor()
    var thickness:CGFloat = 1
    weak var owner:Sprite?
    var shapes:[GraphicsNode] = []
    
    var userInteractionEnabled:Bool = true {
        didSet {
            for shape in shapes {
                shape.userInteractionEnabled = userInteractionEnabled
            }
        }
    }
    
    func makeOwner(owner:Sprite) {
        self.owner = owner
    }
    
    public func beginFill(color:UIColor) {
        fillColor = color
    }
    public func lineStyle(thickness:CGFloat,lineColor:UIColor) {
        self.thickness = thickness
        self.lineColor = lineColor
    }
    public func clear() {
        if let graphicsParent = node.parent {
            node.removeFromParent()
            node = SKNode()
            graphicsParent.addChild(node)
            shapes = []
        }
    }
    public func drawCircle(x:CGFloat,_ y:CGFloat,_ radius:CGFloat) {
        let shapeNode = GraphicsNode(circleOfRadius: radius)
        shapeNode.position = CGPointMake(x, Stage.size.height - (y))
        drawShape(shapeNode)
    }
    public func drawEllipse(x:CGFloat,_ y:CGFloat,_ width:CGFloat,_ height:CGFloat) {
        let shapeNode = GraphicsNode(ellipseOfSize: CGSize(width: width, height: height))
        shapeNode.position = CGPointMake(x, Stage.size.height - (y))
        drawShape(shapeNode)
    }
    public func drawRect(x:CGFloat,_ y:CGFloat,_ width:CGFloat,_ height:CGFloat) {
        let shapeNode = GraphicsNode(rect: CGRect(x: x, y: Stage.size.height - (y + height), width: width, height: height))
        drawShape(shapeNode)
    }
    public func drawTriangle(x1:CGFloat,_ y1:CGFloat,_ x2:CGFloat,_ y2:CGFloat,_ x3:CGFloat,_ y3:CGFloat) {
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, x1, Stage.size.height - y1)
        CGPathAddLineToPoint(path, nil, x2, Stage.size.height - y2)
        CGPathAddLineToPoint(path, nil, x3, Stage.size.height - y3)
        CGPathCloseSubpath(path)
        let shapeNode = GraphicsNode(path: path)
        drawShape(shapeNode)
    }
    private func drawShape(shapeNode:GraphicsNode) {
        shapeNode.fillColor = fillColor
        shapeNode.strokeColor = lineColor
        shapeNode.lineWidth = thickness
        shapeNode.owner = owner
        shapeNode.userInteractionEnabled = userInteractionEnabled
        shapes.push(shapeNode)
        self.node.addChild(shapeNode)
    }
}
