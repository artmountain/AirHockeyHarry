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
    var player1ScoreNode :SKLabelNode?
    var player2ScoreNode :SKLabelNode?
    
    let ballGroup: UInt32 = 0b001
    let batGroup: UInt32 = 0b010
    
    var touchLocationBat1: CGPoint?
    var touchLocationBat2: CGPoint?
    var bat1Touch: UITouch?
    var bat2Touch: UITouch?
    
    var player1score: Int = 0
    var player2score: Int = 0
    
    let scoreColour = UIColor.whiteColor()
    
    override func didMoveToView(view: SKView) {
        // Make pitch
        let goalWidth:CGFloat = 120
        let edgeWidth:CGFloat = 7
        let pitchColour = UIColor.greenColor()
        let centreLine = createCentreLine(pitchColour)
        self.addChild(centreLine)
        
        let leftSide = createPitchEdge(pitchColour, goalWidth: goalWidth, edgeWidth: edgeWidth, isLeftSide: true)
        self.addChild(leftSide)
        let rightSide = createPitchEdge(pitchColour, goalWidth: goalWidth, edgeWidth: edgeWidth, isLeftSide: false)
        self.addChild(rightSide)
        
        // Make player 1 score
        player1ScoreNode = SKLabelNode()
        player1ScoreNode!.text = String(player1score)
        player1ScoreNode!.setScale(6)
        player1ScoreNode!.color = scoreColour
        player1ScoreNode!.position = CGPoint(x : self.frame.midX, y: self.frame.midY - self.frame.height / 4 - player1ScoreNode!.frame.height / 2)
        self.addChild(player1ScoreNode!)
        
        // Make player 2 score
        player2ScoreNode = SKLabelNode()
        player2ScoreNode!.text = String(player1score)
        player2ScoreNode!.setScale(6)
        player2ScoreNode!.color = scoreColour
        player2ScoreNode!.position = CGPoint(x : self.frame.midX, y: self.frame.midY + self.frame.height / 4 - player2ScoreNode!.frame.height / 2)
        self.addChild(player2ScoreNode!)
        
        //making player1 bat
        player1Bat = createObject(UIColor.yellowColor(), xpos:CGRectGetMidX(self.frame), ypos:CGRectGetMidY(self.frame) - 200, radius: 40, bitMask : batGroup)
        self.addChild(player1Bat!)
        
        //making player2 bat
        player2Bat = createObject(UIColor.orangeColor(), xpos:CGRectGetMidX(self.frame), ypos:CGRectGetMidY(self.frame) + 200, radius: 40, bitMask : batGroup)
        self.addChild(player2Bat!)
        
        //making puck
        puck = createObject(UIColor.brownColor(), xpos:CGRectGetMidX(self.frame), ypos:CGRectGetMidY(self.frame), radius: 20, bitMask : ballGroup)
        view.backgroundColor =  UIColor.blackColor()
        self.addChild(puck!)
        
        self.physicsWorld.gravity  = CGVectorMake(0, 0)
    
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in (touches) {
            let location = touch.locationInNode(self)
            if player1Bat!.frame.contains(location) {
                bat1Touch = touch
                touchLocationBat1 = location
            } else if player2Bat!.frame.contains(location) {
                bat2Touch = touch
                touchLocationBat2 = location
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /*
        for touch in (touches) {
            if (touch == bat1Touch) {
                touchLocationBat1 = touch.locationInNode(self)
            } else if (touch == bat2Touch) {
                touchLocationBat2 = touch.locationInNode(self)
            }
        }
*/
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in (touches) {
            if (touch == bat1Touch) {
                bat1Touch = nil
            } else if (touch == bat2Touch) {
                bat2Touch = nil
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        // Check if a goal scored
        if (puck?.position.y < self.frame.minY) {
            incrementPlayer2Score()
        }
        if (puck?.position.y > self.frame.maxY) {
            incrementPlayer1Score()
        }
        
        if (bat1Touch != nil) {
            let dt:CGFloat = 1.0/60.0
            let location: CGPoint = bat1Touch!.locationInNode(self)
            let move = CGVector(dx: location.x-touchLocationBat1!.x, dy: location.y-touchLocationBat1!.y)
            player1Bat!.physicsBody!.velocity=CGVector(dx: move.dx/dt, dy: move.dy/dt)
            touchLocationBat1 = location
        }
        if (bat2Touch != nil) {
            let dt:CGFloat = 1.0/60.0
            let location: CGPoint = bat2Touch!.locationInNode(self)
            let move = CGVector(dx: location.x-touchLocationBat2!.x, dy: location.y-touchLocationBat2!.y)
            player2Bat!.physicsBody!.velocity=CGVector(dx: move.dx/dt, dy: move.dy/dt)
            touchLocationBat2 = location
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
    
    func createCentreLine(colour: UIColor)->SKShapeNode {
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, self.frame.minX, self.frame.midY)
        CGPathAddLineToPoint(path, nil, self.frame.maxX, self.frame.midY)
        
        // Make object
        let sprite = SKShapeNode(path: path)
        sprite.strokeColor = colour
        sprite.fillColor = colour
        
        return sprite
    }
    
    func createPitchEdge(colour: UIColor, goalWidth: CGFloat, edgeWidth: CGFloat, isLeftSide: Bool)->SKShapeNode {
        let path = CGPathCreateMutable()
        if (isLeftSide) {
            let goalLeft = self.frame.midX - goalWidth / 2
            CGPathMoveToPoint(path, nil, self.frame.minX, self.frame.minY)
            CGPathAddLineToPoint(path, nil, self.frame.minX, self.frame.maxY)
            CGPathAddLineToPoint(path, nil, goalLeft, self.frame.maxY)
            CGPathAddLineToPoint(path, nil, goalLeft, self.frame.maxY - edgeWidth)
            CGPathAddLineToPoint(path, nil, self.frame.minX + edgeWidth, self.frame.maxY - edgeWidth)
            CGPathAddLineToPoint(path, nil, self.frame.minX + edgeWidth, self.frame.minY + edgeWidth)
            CGPathAddLineToPoint(path, nil, goalLeft, self.frame.minY + edgeWidth)
            CGPathAddLineToPoint(path, nil, goalLeft, self.frame.minY)
            CGPathAddLineToPoint(path, nil, self.frame.minX, self.frame.minY)
        } else {
            let goalRight = self.frame.midX + goalWidth / 2
        
            CGPathMoveToPoint(path, nil, self.frame.maxX, self.frame.minY)
            CGPathAddLineToPoint(path, nil, self.frame.maxX, self.frame.maxY)
            CGPathAddLineToPoint(path, nil, goalRight, self.frame.maxY)
            CGPathAddLineToPoint(path, nil, goalRight, self.frame.maxY - edgeWidth)
            CGPathAddLineToPoint(path, nil, self.frame.maxX - edgeWidth, self.frame.maxY - edgeWidth)
            CGPathAddLineToPoint(path, nil, self.frame.maxX - edgeWidth, self.frame.minY + edgeWidth)
            CGPathAddLineToPoint(path, nil, goalRight, self.frame.minY + edgeWidth)
            CGPathAddLineToPoint(path, nil, goalRight, self.frame.minY)
            CGPathAddLineToPoint(path, nil, self.frame.maxX, self.frame.minY)
        }
        
        // Make object
        let sprite = SKShapeNode(path: path)
        sprite.strokeColor = colour
        sprite.fillColor = colour
        
        // Give it physics properties
        let physicsBody = SKPhysicsBody(edgeLoopFromPath: path)
        physicsBody.friction=0.0
        physicsBody.mass=0.6
        physicsBody.restitution=0.9
        physicsBody.allowsRotation=true
        physicsBody.dynamic = false;
        sprite.physicsBody = physicsBody
        
        return sprite
    }
    
    func incrementPlayer1Score() {
        ++player1score
        player1ScoreNode!.text = String(player1score)
    }

    func incrementPlayer2Score() {
        ++player2score
        player2ScoreNode!.text = String(player2score)
    }
}