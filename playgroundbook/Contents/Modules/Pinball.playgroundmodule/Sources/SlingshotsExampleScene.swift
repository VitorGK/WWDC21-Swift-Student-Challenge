import SpriteKit

open class SlingshotsExampleScene: SKScene, SKPhysicsContactDelegate {
    
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
    let slingshotRestitution: CGFloat = 1
    let slingshotBRestitution: CGFloat = 0.4
    
    let slingshotFriction: CGFloat = 0.9
    let ballFriction: CGFloat = 0.05
    
    // Textures
    let slingshotLTextures: [SKTexture] = [SKTexture(imageNamed: "SlingshotLNE"),
                                           SKTexture(imageNamed: "SlingshotLOE"),
                                           SKTexture(imageNamed: "SlingshotLBE")]
    let slingshotRTextures: [SKTexture] = [SKTexture(imageNamed: "SlingshotRNE"),
                                           SKTexture(imageNamed: "SlingshotROE"),
                                           SKTexture(imageNamed: "SlingshotRBE")]
    
    // Pinball Parts
    let slingshotL = SKSpriteNode(imageNamed: "SlingshotLNE")
    let slingshotLB = SKSpriteNode(imageNamed: "SlingshotLBE")
    let slingshotR = SKSpriteNode(imageNamed: "SlingshotRNE")
    let slingshotRB = SKSpriteNode(imageNamed: "SlingshotRBE")
    var balls: [Ball] = [Ball()]
    var ballCounter: Int = 0
    var ballCollided: Bool = false
    var ballCreation: Bool = false
    
    open override func didMove(to view: SKView) {
        super.didMove(to: view)
        backgroundColor = .darkGray
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -4)
        
        // Text
        let label = SKLabelNode()
        let text: String = "Other common objects are the slingshots, usually placed near the flippers. It kicks the ball away when it hits at the largest side."
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let range = NSRange(location: 0, length: text.count)
        
        let coloredText: String = "slingshots"
        let rangeColor = (text as NSString).range(of: coloredText)
        
        let attrString = NSMutableAttributedString(string: text)
        attrString.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle,
                                  NSAttributedString.Key.foregroundColor: UIColor.white,
                                  NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)],
                                 range: range)
        attrString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.green, range: rangeColor)
        label.attributedText = attrString
        label.numberOfLines = -1
        label.preferredMaxLayoutWidth = 500
        label.verticalAlignmentMode = .top
        label.position = CGPoint(x: 0, y: 350)
        addChild(label)
        
        // Slingshot Left
        slingshotL.name = "SlingshotL"
        slingshotL.position = CGPoint(x: -150, y: -100)
        slingshotL.physicsBody = SKPhysicsBody(texture: slingshotLTextures[0], size: slingshotLTextures[0].size())
        slingshotL.physicsBody?.isDynamic = false
        slingshotL.physicsBody?.friction = slingshotFriction
        slingshotL.physicsBody?.restitution = slingshotRestitution
        slingshotL.physicsBody?.categoryBitMask = slingshotCategory
        addChild(slingshotL)
        
        // Slingshot Left Body
        slingshotLB.position = slingshotL.position
        slingshotLB.physicsBody = SKPhysicsBody(texture: slingshotLTextures[2], size: slingshotLTextures[2].size())
        slingshotLB.physicsBody?.isDynamic = false
        slingshotLB.physicsBody?.friction = slingshotFriction
        slingshotLB.physicsBody?.restitution = slingshotBRestitution
        slingshotLB.physicsBody?.categoryBitMask = slingshotCategory
        addChild(slingshotLB)
        
        // Slingshot Right
        slingshotR.name = "SlingshotR"
        slingshotR.position = CGPoint(x: 150, y: -100)
        slingshotR.physicsBody = SKPhysicsBody(texture: slingshotRTextures[0], size: slingshotRTextures[0].size())
        slingshotR.physicsBody?.isDynamic = false
        slingshotR.physicsBody?.friction = slingshotFriction
        slingshotR.physicsBody?.restitution = slingshotRestitution
        slingshotR.physicsBody?.categoryBitMask = slingshotCategory
        addChild(slingshotR)
        
        // Slingshot Right Body
        slingshotRB.position = slingshotR.position
        slingshotRB.physicsBody = SKPhysicsBody(texture: slingshotRTextures[2], size: slingshotRTextures[2].size())
        slingshotRB.physicsBody?.isDynamic = false
        slingshotRB.physicsBody?.friction = slingshotFriction
        slingshotRB.physicsBody?.restitution = slingshotBRestitution
        slingshotRB.physicsBody?.categoryBitMask = slingshotCategory
        addChild(slingshotRB)
        
        // Ball
        let ball = Ball(position: CGPoint(x: 350, y: 100), friction: ballFriction, restitution: ballRestitution, categoryBitMask: ballCategory, collisionBitMask: ballCategory | wallCategory | plungerCategory | targetCategory | slingshotCategory | bumperCategory | flipperCategory | removeBallCategory, contactTestBitMask: tunnelLCategory | tunnelUCategory | launcherCategory | lockPlungerCategory)
        balls.removeAll()
        ballCounter += 1
        addChild(ball)
        balls.append(ball)
        ball.physicsBody?.velocity = CGVector(dx: -450, dy: 150)
        
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
        if object.name == "SlingshotL" {
            slingshotL.run(SKAction.animate(with: [slingshotLTextures[1], slingshotLTextures[0]], timePerFrame: 0.1))
            ball.physicsBody?.velocity.dx += 400
            ball.physicsBody?.velocity.dy += 300
        } else if object.name == "SlingshotR" {
            slingshotR.run(SKAction.animate(with: [slingshotRTextures[1], slingshotRTextures[0]], timePerFrame: 0.1))
            ball.physicsBody?.velocity.dx += -400
            ball.physicsBody?.velocity.dy += 300
        }
        ballCollided = true
    }
    
    open func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        if nodeA.name == name {
            collision(between: nodeA, object: nodeB)
        } else if nodeB.name == name {
            collision(between: nodeB, object: nodeA)
        }
    }
    
    open override func update(_ currentTime: TimeInterval) {
        if ballCollided && !ballCreation {
            ballCreation = true
            self.run(SKAction.wait(forDuration: 2), completion: { [self] in
                ballCounter -= 1
                balls[ballCounter].removeFromParent()
                balls.remove(at: ballCounter)
                let newBall = Ball(position: CGPoint(x: 350, y: 100), friction: ballFriction, restitution: ballRestitution, categoryBitMask: ballCategory, collisionBitMask: ballCategory | wallCategory | plungerCategory | targetCategory | slingshotCategory | bumperCategory | flipperCategory | removeBallCategory, contactTestBitMask: tunnelLCategory | tunnelUCategory | launcherCategory | lockPlungerCategory)
                newBall.zPosition = 1
                ballCounter += 1
                addChild(newBall)
                balls.append(newBall)
                newBall.physicsBody?.velocity = CGVector(dx: -450, dy: 150)
                ballCreation = false
                ballCollided = false
            })
        }
    }
}

