import SpriteKit

open class BumpersExampleScene: SKScene, SKPhysicsContactDelegate {
    
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
    let bumperRestitution: CGFloat = 0.8

    let ballFriction: CGFloat = 0.05
    let bumperFriction: CGFloat = 0.9
    
    // Textures
    let bumperLTextures: [SKTexture] = [SKTexture(imageNamed: "BumperLN"),
                                        SKTexture(imageNamed: "BumperLC")]
    
    // Pinball Parts
    let bumperL = SKSpriteNode(imageNamed: "BumperLN")
    let bumper2 = SKSpriteNode(imageNamed: "BumperLN")
    let bumper3 = SKSpriteNode(imageNamed: "BumperLN")
    let bumper4 = SKSpriteNode(imageNamed: "BumperLN")
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
        
        let text: String = "We also have the bumpers. They have the same action as the slingshots: kick the ball away when hit, but also adding some points."
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let range = NSRange(location: 0, length: text.count)
        
        let coloredText: String = "bumpers"
        let rangeColor = (text as NSString).range(of: coloredText)
        
        let attrString = NSMutableAttributedString(string: text)
        attrString.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle,
                                  NSAttributedString.Key.foregroundColor: UIColor.white,
                                  NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)],
                                 range: range)
        attrString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: rangeColor)
        label.attributedText = attrString
        label.numberOfLines = -1
        label.preferredMaxLayoutWidth = 500
        label.verticalAlignmentMode = .top
        label.position = CGPoint(x: 0, y: 350)
        addChild(label)
        
        // Bumper Left
        bumperL.name = "BumperN"
        bumperL.position = CGPoint(x: 170, y: -200)
        bumperL.physicsBody = SKPhysicsBody(texture: bumperLTextures[0], size: bumperLTextures[1].size())
        bumperL.physicsBody?.isDynamic = false
        bumperL.physicsBody?.restitution = bumperRestitution
        bumperL.physicsBody?.friction = bumperFriction
        bumperL.physicsBody?.categoryBitMask = bumperCategory
        addChild(bumperL)
        
        bumper2.name = "BumperN"
        bumper2.position = CGPoint(x: 370, y: -300)
        bumper2.physicsBody = SKPhysicsBody(texture: bumperLTextures[0], size: bumperLTextures[1].size())
        bumper2.physicsBody?.isDynamic = false
        bumper2.physicsBody?.restitution = bumperRestitution
        bumper2.physicsBody?.friction = bumperFriction
        bumper2.physicsBody?.categoryBitMask = bumperCategory
        addChild(bumper2)
        
        bumper3.name = "BumperN"
        bumper3.position = CGPoint(x: 270, y: -300)
        bumper3.physicsBody = SKPhysicsBody(texture: bumperLTextures[0], size: bumperLTextures[1].size())
        bumper3.physicsBody?.isDynamic = false
        bumper3.physicsBody?.restitution = bumperRestitution
        bumper3.physicsBody?.friction = bumperFriction
        bumper3.physicsBody?.categoryBitMask = bumperCategory
        addChild(bumper3)
        
        bumper4.name = "BumperN"
        bumper4.position = CGPoint(x: 470, y: -200)
        bumper4.physicsBody = SKPhysicsBody(texture: bumperLTextures[0], size: bumperLTextures[1].size())
        bumper4.physicsBody?.isDynamic = false
        bumper4.physicsBody?.restitution = bumperRestitution
        bumper4.physicsBody?.friction = bumperFriction
        bumper4.physicsBody?.categoryBitMask = bumperCategory
        addChild(bumper4)
        
        
        // Ball
        let ball = Ball(position: CGPoint(x: -11.5, y: 100), friction: ballFriction, restitution: ballRestitution, categoryBitMask: ballCategory, collisionBitMask: ballCategory | wallCategory | plungerCategory | targetCategory | slingshotCategory | bumperCategory | flipperCategory | removeBallCategory, contactTestBitMask: tunnelLCategory | tunnelUCategory | launcherCategory | lockPlungerCategory)
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
        if object.name == "BumperN" {
            object.run(SKAction.animate(with: bumperLTextures.reversed(), timePerFrame: 0.1))
            ball.physicsBody?.velocity.dx += 250 * (ball.physicsBody!.velocity.dx < 0 ? -1 : 1)
            ball.physicsBody?.velocity.dy += 250 * (ball.physicsBody!.velocity.dy < 0 ? -1 : 1)
        }
        if !ballCreation {
            ballCollided = true
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
    }
    
    open override func update(_ currentTime: TimeInterval) {
        if ballCollided && !ballCreation {
            ballCreation = true
            self.run(SKAction.wait(forDuration: 3), completion: { [self] in
                ballCounter -= 1
                balls[ballCounter].removeFromParent()
                balls.remove(at: ballCounter)
                let newBall = Ball(position: CGPoint(x: -11.5, y: 100), friction: ballFriction, restitution: ballRestitution, categoryBitMask: ballCategory, collisionBitMask: ballCategory | wallCategory | plungerCategory | targetCategory | slingshotCategory | bumperCategory | flipperCategory | removeBallCategory, contactTestBitMask: tunnelLCategory | tunnelUCategory | launcherCategory | lockPlungerCategory)
                newBall.zPosition = 1
                ballCounter += 1
                addChild(newBall)
                balls.append(newBall)
                ballCreation = false
                ballCollided = false
            })
        }
    }
}

