//
//  TitleScreen.swift
//  AirHockey
//
//  Created by user on 15/11/2015.
//  Copyright (c) 2015 Harry. All rights reserved.
//

import SpriteKit
import Foundation

class TitleScreen: SKScene {
    override init(size: CGSize)  {
        super.init(size: size)
      /*
        let titleNode = SKLabelNode(fontNamed: fontName)
        titleNode.fontSize = titleFontSize
        titleNode.position = CGPoint(x: size.width / 2, y: size.height - 100)
        titleNode.text = "Game of life rules"
        self.addChild(titleNode)
        
      */
        
        self.backgroundColor = SKColor.blackColor()
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Start!";
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        self.addChild(myLabel)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            // Transition to Game of Life
            let gameScene = GameScene(size: self.size)
            let transition = SKTransition.flipHorizontalWithDuration(0.2)
            gameScene.scaleMode = SKSceneScaleMode.AspectFill
            self.scene!.view?.presentScene(gameScene, transition: transition)
        }
    }
    
}