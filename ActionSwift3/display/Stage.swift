//
//  Stage.swift
//  ActionSwiftSK
//
//  Created by Craig on 6/05/2015.
//  Copyright (c) 2015 Interactive Coconut. All rights reserved.
//

import SpriteKit
import UIKit

public class Stage: DisplayObjectContainer, StageSceneProtocol {
    private let skView:SKView
    static var size:CGSize = CGSize(width: 0, height: 0)
    
    init(_ skView:SKView) {
        self.skView = skView
        Stage.size = CGSize(width: self.skView.bounds.width, height: self.skView.bounds.height)
        
        super.init()

        
        let stageScene = StageScene(size: Stage.size)
        stageScene.stageSceneDelegate = self
        stageScene.scaleMode = SKSceneScaleMode.ResizeFill
        stageScene.backgroundColor = UIColor.whiteColor()
        
        skView.presentScene(stageScene)
        
        stageScene.addChild(self.node)
        
    }
    class func getSize()->CGSize {
        return Stage.size
    }
    class var stageWidth:CGFloat {
        return self.getSize().width
    }
    class var stageHeight:CGFloat {
        return self.getSize().height
    }
}
