//
//  StageScene.swift
//  ActionSwiftSK
//
//  Created by Craig on 7/05/2015.
//  Copyright (c) 2015 Interactive Coconut. All rights reserved.
//

import SpriteKit

protocol StageSceneProtocol {
    func update(currentTime:CFTimeInterval)
}
public class StageScene: SKScene {
    var stageSceneDelegate:StageSceneProtocol?
    override public func didMoveToView(view: SKView) {
        
    }
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touched stage")
/*        for touch in touches {
            if let parent = parent {
                let loc = touch.locationInNode(parent)
                var node = self.nodeAtPoint(loc)
            }
        }*/
    }
    
    override public func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        self.stageSceneDelegate?.update(currentTime)
    }
}