import SpriteKit

open class FlippersExampleScene: SKScene, SKPhysicsContactDelegate {
    
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
    let flipperRestitution: CGFloat = 0.4
    
    let ballFriction: CGFloat = 0.05

    // Pinball Parts
    var flipperLeft: Flipper?
    var flipperRight: Flipper?
    let flipperLocker = SKShapeNode(rect: CGRect(x: -200, y: -220, width: 400, height: 100))
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
        
        let text: String = "The most common controllable objects in the playfield are the flippers, which are used to kick the ball."
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let range = NSRange(location: 0, length: text.count)
        
        let coloredText: String = "flippers"
        let rangeColor = (text as NSString).range(of: coloredText)
        
        let attrString = NSMutableAttributedString(string: text)
        attrString.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle,
                                  NSAttributedString.Key.foregroundColor: UIColor.white,
                                  NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)],
                                 range: range)
        attrString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: rangeColor)
        label.attributedText = attrString
        label.numberOfLines = -1
        label.preferredMaxLayoutWidth = 500
        label.verticalAlignmentMode = .top
        label.position = CGPoint(x: 0, y: 350)
        addChild(label)
        
        // Flipper Left
        flipperLeft = Flipper(anchorPosition: CGPoint(x: -104.25, y: -100), name: "FlipperL", zRotation: -30, restitution: flipperRestitution, categoryBitMask: flipperCategory, side: "L")
        flipperLeft!.physicsBody?.collisionBitMask = lockCategory
        flipperLeft!.physicsBody?.contactTestBitMask = flipperLeft!.physicsBody!.collisionBitMask
        guard let flipperLeftAnchor = flipperLeft?.createAnchor() else { return }
        addChild(flipperLeftAnchor)
        flipperLeftAnchor.addChild(flipperLeft!)
        let flipperLeftJoint = SKPhysicsJointPin.joint(withBodyA: flipperLeftAnchor.physicsBody!, bodyB: flipperLeft!.physicsBody!, anchor: flipperLeftAnchor.position)
        physicsWorld.add(flipperLeftJoint)
        
        // Flipper Right
        flipperRight = Flipper(anchorPosition: CGPoint(x: 104.25, y: -100), name: "FlipperR", zRotation: 210, restitution: flipperRestitution, categoryBitMask: flipperCategory, side: "R")
        flipperRight!.physicsBody?.collisionBitMask = lockCategory
        flipperRight!.physicsBody?.contactTestBitMask = flipperRight!.physicsBody!.collisionBitMask
        guard let flipperRightAnchor = flipperRight?.createAnchor() else { return }
        addChild(flipperRightAnchor)
        flipperRightAnchor.addChild(flipperRight!)
        let flipperRightJoint = SKPhysicsJointPin.joint(withBodyA: flipperRightAnchor.physicsBody!, bodyB: flipperRight!.physicsBody!, anchor: flipperRightAnchor.position)
        physicsWorld.add(flipperRightJoint)
        
        // Flipper Locker
        flipperLocker.name = "Lock"
        flipperLocker.fillColor = .clear
        flipperLocker.lineWidth = 0
        flipperLocker.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: -200, y: -43, width: 400, height: 100))
        flipperLocker.physicsBody?.isDynamic = false
        flipperLocker.physicsBody?.categoryBitMask = lockCategory
        addChild(flipperLocker)
        
        // Ball
        let ball = Ball(position: CGPoint(x: -60, y: 150), friction: ballFriction, restitution: ballRestitution, categoryBitMask: ballCategory, collisionBitMask: ballCategory | wallCategory | plungerCategory | targetCategory | slingshotCategory | bumperCategory | flipperCategory | removeBallCategory, contactTestBitMask: tunnelLCategory | tunnelUCategory | launcherCategory | lockPlungerCategory)
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
        if object.name == "FlipperL" {
            flipperLeft!.raise()
            self.run(SKAction.wait(forDuration: 0.5), completion: {
                self.flipperLeft!.lower()
            })
        } else if object.name == "FlipperR" {
            flipperRight!.raise()
            self.run(SKAction.wait(forDuration: 0.5), completion: {
                self.flipperRight!.lower()
            })
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
        if (nodeA.name == "FlipperL" && nodeB.name == "Lock") || (nodeB.name == "FlipperL" && nodeA.name == "Lock") {
            flipperLeft?.lockFlipperUp()
        } else if (nodeA.name == "FlipperR" && nodeB.name == "Lock") || (nodeB.name == "FlipperR" && nodeA.name == "Lock") {
            flipperRight?.lockFlipperUp()
        }
    }
    
    open override func update(_ currentTime: TimeInterval) {
        if ballCollided && !ballCreation {
            ballCreation = true
            self.run(SKAction.wait(forDuration: 2), completion: { [self] in
                ballCounter -= 1
                balls[ballCounter].removeFromParent()
                balls.remove(at: ballCounter)
                let newBall = Ball(position: CGPoint(x: -60, y: 150), friction: ballFriction, restitution: ballRestitution, categoryBitMask: ballCategory, collisionBitMask: ballCategory | wallCategory | plungerCategory | targetCategory | slingshotCategory | bumperCategory | flipperCategory | removeBallCategory, contactTestBitMask: tunnelLCategory | tunnelUCategory | launcherCategory | lockPlungerCategory)
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

