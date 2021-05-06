import SpriteKit

open class PlungerExampleScene: SKScene, SKPhysicsContactDelegate {
    
    // Masks Categories
    let ballCategory: UInt32 = 0x1 << 1
    let flipperCategory: UInt32 = 0x1 << 2
    let bumperCategory: UInt32 = 0x1 << 3
    let slingshotCategory: UInt32 = 0x1 << 4
    let targetCategory: UInt32 = 0x1 << 5
    let plungerCategory: UInt32 = 0x1 << 6
    let wallCategory: UInt32 = 0x1 << 7
    let lockCategory: UInt32 = 0x1 << 8
    let tunnelLCategory: UInt32 = 0x1 << 9
    let tunnelUCategory: UInt32 = 0x1 << 10
    let launcherCategory: UInt32 = 0x1 << 11
    let lockPlungerCategory: UInt32 = 0x1 << 12
    let removeBallCategory: UInt32 = 0x1 << 13
    
    // Pinball Physics
    let ballRestitution: CGFloat = 0.4
    let wallRestitution: CGFloat = 0.1
    let plungerRestitution: CGFloat = 0.2
    
    let ballFriction: CGFloat = 0.05
    
    // Pinball Parts
    let ballRampIn0 = SKSpriteNode(imageNamed: "BallRampIn0E")
    let ballRampIn1 = SKSpriteNode(imageNamed: "BallRampIn1E")
    var plunger: Plunger?
    var balls: [Ball] = [Ball()]
    var ballCounter: Int = 0
    var ballCollided: Bool = false
    var ballCreation: Bool = false
    var plungerReleased: Bool = false
    var firstTouch: Bool = true
    
    // Notificators
    let lockPlunger = SKNode()
    
    // Lockers
    var plungerLocked: Bool = false
    
    open override func didMove(to view: SKView) {
        super.didMove(to: view)
        backgroundColor = .darkGray
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -4)
        
        // Text
        let label = SKLabelNode()
        
        let text: String = "And finally, the plunger. Without it, we wouldn't be able to shoot the ball into the playfield."
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let range = NSRange(location: 0, length: text.count)
        
        let coloredText: String = "plunger"
        let rangeColor = (text as NSString).range(of: coloredText)
        
        let attrString = NSMutableAttributedString(string: text)
        attrString.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle,
                                  NSAttributedString.Key.foregroundColor: UIColor.white,
                                  NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)],
                                 range: range)
        attrString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.yellow, range: rangeColor)
        label.attributedText = attrString
        label.numberOfLines = -1
        label.preferredMaxLayoutWidth = 500
        label.verticalAlignmentMode = .top
        label.position = CGPoint(x: 0, y: 350)
        addChild(label)
        
        let positions = CGPoint(x: 0, y: 25)
        
        // Ball Ramp In
        ballRampIn0.name = "BallRampIn"
        ballRampIn0.position = positions
        ballRampIn0.physicsBody = SKPhysicsBody(texture: ballRampIn0.texture!, size: ballRampIn0.texture!.size())
        ballRampIn0.physicsBody?.isDynamic = false
        ballRampIn0.physicsBody?.restitution = 0
        ballRampIn0.physicsBody?.friction = 0
        ballRampIn0.physicsBody?.categoryBitMask = wallCategory
        addChild(ballRampIn0)
        
        ballRampIn1.name = "BallRampIn"
        ballRampIn1.position = positions
        ballRampIn1.physicsBody = SKPhysicsBody(texture: ballRampIn1.texture!, size: ballRampIn1.texture!.size())
        ballRampIn1.physicsBody?.isDynamic = false
        ballRampIn1.physicsBody?.restitution = 0
        ballRampIn1.physicsBody?.friction = 0
        ballRampIn1.physicsBody?.categoryBitMask = wallCategory
        addChild(ballRampIn1)
        
        // Plunger
        plunger = Plunger(imageNamed: "PlungerE", restitution: plungerRestitution, categoryBitMask: plungerCategory, collisionBitMask: wallCategory)
        plunger!.position = positions
        addChild(plunger!)
        
        // Ball
        let ball = Ball(position: CGPoint(x: 0, y: 100), friction: ballFriction, restitution: ballRestitution, categoryBitMask: ballCategory, collisionBitMask: ballCategory | wallCategory | plungerCategory | targetCategory | slingshotCategory | bumperCategory | flipperCategory | removeBallCategory, contactTestBitMask: tunnelLCategory | tunnelUCategory | launcherCategory | lockPlungerCategory)
        balls.removeAll()
        ballCounter += 1
        addChild(ball)
        balls.append(ball)
        
        // Text
        let labelNext = SKLabelNode()
        
        let textNext: String = "Tap the screen for next page"
        let rangeNext = NSRange(location: 0, length: textNext.count)
        
        let attrStringNext = NSMutableAttributedString(string: textNext)
        attrStringNext.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle,
                                  NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                                  NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)],
                                 range: rangeNext)
        labelNext.attributedText = attrStringNext
        labelNext.numberOfLines = -1
        labelNext.preferredMaxLayoutWidth = 500
        labelNext.verticalAlignmentMode = .bottom
        labelNext.position = CGPoint(x: 0, y: -350)
        addChild(labelNext)
    }
    
    open override func didChangeSize(_ oldSize: CGSize) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    func collision(between ball: SKNode, object: SKNode) {
        if object.name == "Plunger" {
            if !plungerReleased {
                ballCollided = true
            } else if firstTouch {
                ball.physicsBody?.velocity = CGVector(dx: 0, dy: 1500)
                firstTouch = false
            }
        }
    }
    
    open func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        if nodeA.name == name {
            collision(between: nodeA, object: nodeB)
        } else if nodeB.name == name {
            collision(between: nodeB, object: nodeA)
        }
        if (nodeA.name == "Plunger" && nodeB.name == "BallRampIn" && plunger!.isMoving) || (nodeB.name == "Plunger" && nodeA.name == "BallRampIn" && plunger!.isMoving) {
            plunger?.stopPlunger()
            plungerReleased = false
            ballCollided = false
        }
    }
    
    open override func update(_ currentTime: TimeInterval) {
        if ballCollided && plunger!.dY >= -50 {
            plunger!.run(SKAction.move(by: CGVector(dx: 0, dy: -1), duration: 0.1))
            plunger!.dY += -2
        } else if ballCollided && plunger!.dY < -50 {
            self.run(SKAction.wait(forDuration: 2), completion: { [self] in
                plungerReleased = true
                plunger!.releasePlunger()
            })
        }
        if ballCollided && !ballCreation {
            ballCreation = true
            self.run(SKAction.wait(forDuration: 5), completion: { [self] in
                ballCounter -= 1
                balls[ballCounter].removeFromParent()
                balls.remove(at: ballCounter)
                let newBall = Ball(position: CGPoint(x: 0, y: 100), friction: ballFriction, restitution: ballRestitution, categoryBitMask: ballCategory, collisionBitMask: ballCategory | wallCategory | plungerCategory | targetCategory | slingshotCategory | bumperCategory | flipperCategory | removeBallCategory, contactTestBitMask: tunnelLCategory | tunnelUCategory | launcherCategory | lockPlungerCategory)
                newBall.zPosition = 1
                ballCounter += 1
                addChild(newBall)
                balls.append(newBall)
                ballCreation = false
                ballCollided = false
                plungerReleased = false
            })
        }
    }
}

