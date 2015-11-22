//
//  GameScene.swift
//  AirHockey
//
//  Created by user on 10/11/2015.
//  Copyright (c) 2015 Harry. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var player1Bat :SKNode?
    var player2Bat :SKNode?
    var puck: SKNode?
    
    override func didMoveToView(view: SKView) {
        //making player1 bat
        player1Bat = createObject(UIColor.yellowColor(), xpos:CGRectGetMidX(self.frame), ypos:CGRectGetMidY(self.frame) - 200, radius: 20)
        
        //making player2 bat
        player2Bat = createObject(UIColor.orangeColor(), xpos:CGRectGetMidX(self.frame), ypos:CGRectGetMidY(self.frame) + 200, radius: 20)
        
        //making puck
        puck = createObject(UIColor.whiteColor(), xpos:CGRectGetMidX(self.frame), ypos:CGRectGetMidY(self.frame), radius: 10)
    
        view.backgroundColor =  UIColor.blackColor()
        
        self.addChild(player1Bat!)
        self.addChild(player2Bat!)
        self.addChild(puck!)
        
        self.physicsWorld.gravity  = CGVectorMake(0, 0)
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
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in (touches as! Set<UITouch>) {
            let touchLocation = touch.locationInNode(self)
            /*
            let touchedNode = self.nodeAtPoint(touchLocation)
            if !touchedNode.isEqual(nil) {
                var i = 1
                ++i
            }
            */
            
            
            var touchedNode = self.nodeAtPoint(touchLocation)
            if touchedNode is SKShapeNode {
              //  let selectedNode = touchedNode.parent
                let selectedNode = touchedNode
                let previousPosition = touch.previousLocationInNode(self)
                let translation = CGPoint(x: touchLocation.x - previousPosition.x, y: touchLocation.y - previousPosition.y)
                selectedNode.position = CGPoint(x: touchLocation.x + translation.x, y: touchLocation.y + translation.y)
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func createObject(colour: UIColor, xpos: CGFloat, ypos: CGFloat, radius: CGFloat)->SKShapeNode {
        /*
        // Make object
        var sprite = SKSpriteNode()
        let spriteShape = SKShapeNode(circleOfRadius : radius)
        spriteShape.fillColor = colour
        sprite.addChild(spriteShape)
        sprite.position = CGPoint(x:xpos, y:ypos);
        
        // Give it physics properties
        var test = spriteShape.frame.size.width/2
        sprite.physicsBody = SKPhysicsBody(circleOfRadius: spriteShape.frame.size.width/2)
        sprite.physicsBody!.friction=0.0
        sprite.physicsBody!.mass=0.6
        sprite.physicsBody!.restitution=3
        sprite.physicsBody!.allowsRotation=true
        
        return sprite
        */
        // Make object
        let spriteShape = SKShapeNode(circleOfRadius : radius)
        spriteShape.fillColor = colour
        spriteShape.position = CGPoint(x:xpos, y:ypos);
        
        // Give it physics properties
       spriteShape.physicsBody = SKPhysicsBody(circleOfRadius: spriteShape.frame.size.width/2)
        spriteShape.physicsBody!.friction=0.0
        spriteShape.physicsBody!.mass=0.6
        spriteShape.physicsBody!.restitution=3
        spriteShape.physicsBody!.allowsRotation=true
        
        return spriteShape

     
       
    }
}
