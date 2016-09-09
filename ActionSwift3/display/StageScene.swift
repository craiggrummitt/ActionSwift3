//
//  StageScene.swift
//  ActionSwiftSK
//
//  Created by Craig on 7/05/2015.
//  Copyright (c) 2015 Interactive Coconut. All rights reserved.
//

import SpriteKit

protocol StageSceneProtocol {
    func update(_ currentTime:CFTimeInterval)
}
open class StageScene: SKScene {
    var stageSceneDelegate:StageSceneProtocol?
    override open func didMove(to view: SKView) {
        
    }
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touched stage")
/*        for touch in touches {
            if let parent = parent {
                let loc = touch.locationInNode(parent)
                var node = self.nodeAtPoint(loc)
            }
        }*/
    }
    
    override open func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        self.stageSceneDelegate?.update(currentTime)
    }
}
