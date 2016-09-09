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
open class Graphics: Object {
    var node = SKNode()
    var fillColor = UIColor.black
    var lineColor = UIColor.black
    var thickness:CGFloat = 1
    weak var owner:Sprite?
    var shapes:[GraphicsNode] = []
    
    var userInteractionEnabled:Bool = true {
        didSet {
            for shape in shapes {
                shape.isUserInteractionEnabled = userInteractionEnabled
            }
        }
    }
    
    func makeOwner(_ owner:Sprite) {
        self.owner = owner
    }
    
    open func beginFill(_ color:UIColor) {
        fillColor = color
    }
    open func lineStyle(_ thickness:CGFloat,lineColor:UIColor) {
        self.thickness = thickness
        self.lineColor = lineColor
    }
    open func clear() {
        if let graphicsParent = node.parent {
            node.removeFromParent()
            node = SKNode()
            graphicsParent.addChild(node)
            shapes = []
        }
    }
    open func drawCircle(_ x:CGFloat,_ y:CGFloat,_ radius:CGFloat) {
        let shapeNode = GraphicsNode(circleOfRadius: radius)
        shapeNode.position = CGPoint(x: x, y: Stage.size.height - (y))
        drawShape(shapeNode)
    }
    open func drawEllipse(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat,_ height:CGFloat) {
        let shapeNode = GraphicsNode(ellipseOf: CGSize(width: width, height: height))
        shapeNode.position = CGPoint(x: x, y: Stage.size.height - (y))
        drawShape(shapeNode)
    }
    open func drawRect(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat,_ height:CGFloat) {
        let shapeNode = GraphicsNode(rect: CGRect(x: x, y: Stage.size.height - (y + height), width: width, height: height))
        drawShape(shapeNode)
    }
    open func drawTriangle(_ x1:CGFloat,_ y1:CGFloat,_ x2:CGFloat,_ y2:CGFloat,_ x3:CGFloat,_ y3:CGFloat) {
        let path = CGMutablePath()
        path.move(to: CGPoint(x:x1, y:Stage.size.height - y1))
        path.addLine(to: CGPoint(x: x2, y: Stage.size.height - y2))
        path.addLine(to: CGPoint(x: x3, y: Stage.size.height - y3))
        path.closeSubpath()
        let shapeNode = GraphicsNode(path: path)
        drawShape(shapeNode)
    }
    fileprivate func drawShape(_ shapeNode:GraphicsNode) {
        shapeNode.fillColor = fillColor
        shapeNode.strokeColor = lineColor
        shapeNode.lineWidth = thickness
        shapeNode.owner = owner
        shapeNode.isUserInteractionEnabled = userInteractionEnabled
        shapes.push(shapeNode)
        self.node.addChild(shapeNode)
    }
}
