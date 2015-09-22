//
//  Stage.swift
//  ActionSwiftSK
//
//  Created by Craig on 6/05/2015.
//  Copyright (c) 2015 Interactive Coconut. All rights reserved.
//

import SpriteKit
import UIKit

/**
Instantiate a Stage class passing in the skView.
*/
public class Stage: DisplayObjectContainer {
    private let skView:SKView
    static var size:CGSize = CGSize(width: 0, height: 0)
    
    public init(_ skView:SKView) {
        self.skView = skView
        Stage.size = CGSize(width: self.skView.bounds.width, height: self.skView.bounds.height)
        
        super.init()

        
        let stageScene = StageScene(size: Stage.size)
        stageScene.stageSceneDelegate = self
        stageScene.scaleMode = SKSceneScaleMode.ResizeFill
        stageScene.backgroundColor = UIColor.whiteColor()
        
        skView.presentScene(stageScene)
        
        stageScene.addChild(self.node)
        self.stage = self
        
    }
    class public func getSize()->CGSize {
        return Stage.size
    }
    class public var stageWidth:CGFloat {
        return self.getSize().width
    }
    class public var stageHeight:CGFloat {
        return self.getSize().height
    }
}
