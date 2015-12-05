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
    
    let ballGroup: UInt32 = 0b001
    let batGroup: UInt32 = 0b010
    
    var sprite: SKNode?
    var touchPoint: CGPoint = CGPoint()
    var touching: Bool = false
    
    override func didMoveToView(view: SKView) {
        //making player1 bat
        player1Bat = createObject(UIColor.yellowColor(), xpos:CGRectGetMidX(self.frame), ypos:CGRectGetMidY(self.frame) - 200, radius: 20, bitMask : batGroup)
        
        //making player2 bat
        player2Bat = createObject(UIColor.orangeColor(), xpos:CGRectGetMidX(self.frame), ypos:CGRectGetMidY(self.frame) + 200, radius: 20, bitMask : batGroup)
        
        //making puck
        puck = createObject(UIColor.whiteColor(), xpos:CGRectGetMidX(self.frame), ypos:CGRectGetMidY(self.frame), radius: 10, bitMask : ballGroup)
        view.backgroundColor =  UIColor.blackColor()
        /*
        var board = SKShapeNode(rect: CGRect(x: 10, y: 10, width: 300, height: 500), cornerRadius : 10)
        board.physicsBody! = SKPhysicsBody(size : board.s
        board.fillColor = UIColor.whiteColor()
        */
        let physicsBody = SKPhysicsBody (edgeLoopFromRect: self.frame)
        self.physicsBody = physicsBody
        
        self.addChild(player1Bat!)
        self.addChild(player2Bat!)
        self.addChild(puck!)
      //  self.addChild(board)
        
        self.physicsWorld.gravity  = CGVectorMake(0, 0)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in (touches) {
         
        }
        
        let touch = touches.first
        if touch != nil {
            let location = touch!.locationInNode(self)
            if player1Bat!.frame.contains(location) {
                sprite = player1Bat
                touchPoint = location
                touching = true
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in (touches ) {
            let touchLocation = touch.locationInNode(self)
            
        }
        
        let touch = touches.first! as UITouch
        let location = touch.locationInNode(self)
        touchPoint = location
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touching = false
    }
    
    override func update(currentTime: CFTimeInterval) {
        if touching {
            let dt:CGFloat = 1.0/60.0
            let move = CGVector(dx: touchPoint.x-sprite!.position.x, dy: touchPoint.y-sprite!.position.y)
            sprite!.physicsBody!.velocity=CGVector(dx: move.dx/dt, dy: move.dy/dt)
        }
    }
    
    func createObject(colour: UIColor, xpos: CGFloat, ypos: CGFloat, radius: CGFloat, bitMask: UInt32)->SKShapeNode {
        // Make object
        let sprite = SKShapeNode(circleOfRadius : radius)
        sprite.strokeColor = colour
        sprite.fillColor = colour
        sprite.position = CGPoint(x:xpos, y:ypos);
        
        // Give it physics properties
        let physicsBody = SKPhysicsBody(circleOfRadius:sprite.frame.size.width/2)
         physicsBody.friction=0.0
        physicsBody.mass=0.6
        physicsBody.restitution=0.9
        physicsBody.allowsRotation=true
        physicsBody.dynamic = true;
        physicsBody.categoryBitMask = bitMask
        sprite.physicsBody = physicsBody
        
        return sprite
    }
}
