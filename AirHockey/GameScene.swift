//
//  GameScene.swift
//  AirHockey
//
//  Created by user on 10/11/2015.
//  Copyright (c) 2015 Harry. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var player1Bat :SKSpriteNode?
    var player2Bat :SKSpriteNode?
    
    
    override func didMoveToView(view: SKView) {
        // Make player bats
        player1Bat = SKSpriteNode()
        let player1BatShape = SKShapeNode(circleOfRadius : 20)
        player1BatShape.fillColor = UIColor.yellowColor()
        player1Bat?.addChild(player1BatShape)
        player1Bat!.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) - 200);
       
        player2Bat = SKSpriteNode()
        let player2BatShape = SKShapeNode(circleOfRadius : 20)
        player2BatShape.fillColor = UIColor.orangeColor()
        player2Bat?.addChild(player2BatShape)
        player2Bat!.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + 200);
        // player1Bat = SKSpriteNode(circleOfRadius : 20)
       
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Start!";
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        self.view?.backgroundColor =  UIColor.blackColor()
        self.addChild(myLabel)
        self.addChild(player1Bat!)
        self.addChild(player2Bat!)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            /*
            let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)
*/
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
