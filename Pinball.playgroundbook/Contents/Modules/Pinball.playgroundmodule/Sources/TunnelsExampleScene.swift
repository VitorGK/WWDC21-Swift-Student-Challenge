import SpriteKit

open class TunnelsExampleScene: SKScene, SKPhysicsContactDelegate {
    
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

    let ballFriction: CGFloat = 0.05
    
    // Pinball Parts
    let obstacle0 = SKSpriteNode(imageNamed: "Obstacle0E")
    let obstacle1 = SKSpriteNode(imageNamed: "Obstacle1E")
    let obstacle2 = SKSpriteNode(imageNamed: "Obstacle2E")
    let tunnelsFG = SKSpriteNode(imageNamed: "TunnelsFGE")
    let tunnelsBG = SKSpriteNode(imageNamed: "TunnelsBGE")
    var balls: [Ball] = [Ball()]
    var ballCounter: Int = 0
    var ballCollided: Bool = false
    var ballCreation: Bool = false
    
    // Notificators
    let tunnelL = SKNode()
    let tunnelU = SKNode()
    let launcher = SKNode()
    
    open override func didMove(to view: SKView) {
        super.didMove(to: view)
        backgroundColor = .darkGray
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -4)
        
        // Text
        let label = SKLabelNode()
        
        let text: String = "There are tunnels which move the ball from place to place, and launchers that shoot the ball if it goes in it."
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let range = NSRange(location: 0, length: text.count)
        
        let coloredText1: String = "tunnels"
        let rangeColor1 = (text as NSString).range(of: coloredText1)
        let coloredText2: String = "launchers"
        let rangeColor2 = (text as NSString).range(of: coloredText2)
        
        let attrString = NSMutableAttributedString(string: text)
        attrString.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle,
                                  NSAttributedString.Key.foregroundColor: UIColor.white,
                                  NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)],
                                 range: range)
        attrString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: rangeColor1)
        attrString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.brown, range: rangeColor2)
        label.attributedText = attrString
        label.numberOfLines = -1
        label.preferredMaxLayoutWidth = 500
        label.verticalAlignmentMode = .top
        label.position = CGPoint(x: 0, y: 150)
        addChild(label)
        
        let positions = CGPoint(x: 0, y: 50)
        
        // Obstacles
        obstacle0.position = positions
        obstacle0.physicsBody = SKPhysicsBody(texture: obstacle0.texture!, size: obstacle0.texture!.size())
        obstacle0.physicsBody?.isDynamic = false
        obstacle0.physicsBody?.restitution = wallRestitution
        obstacle0.physicsBody?.categoryBitMask = wallCategory
        addChild(obstacle0)
        
        obstacle1.position = positions
        obstacle1.physicsBody = SKPhysicsBody(texture: obstacle1.texture!, size: obstacle1.texture!.size())
        obstacle1.physicsBody?.isDynamic = false
        obstacle1.physicsBody?.restitution = wallRestitution
        obstacle1.physicsBody?.categoryBitMask = wallCategory
        addChild(obstacle1)
        
        obstacle2.position = positions
        obstacle2.physicsBody = SKPhysicsBody(texture: obstacle2.texture!, size: obstacle2.texture!.size())
        obstacle2.physicsBody?.isDynamic = false
        obstacle2.physicsBody?.restitution = wallRestitution
        obstacle2.physicsBody?.categoryBitMask = wallCategory
        addChild(obstacle2)
        
        // Tunnels Background
        tunnelsFG.zPosition = 0
        tunnelsBG.position = positions
        addChild(tunnelsBG)
        
        // Tunnel Left
        tunnelL.name = "TunnelL"
        tunnelL.position = CGPoint(x: -220, y: 256)
        tunnelL.physicsBody = SKPhysicsBody(circleOfRadius: 5)
        tunnelL.physicsBody?.isDynamic = false
        tunnelL.physicsBody?.categoryBitMask = tunnelLCategory
        addChild(tunnelL)
        
        // Tunnel Upper
        tunnelU.name = "TunnelU"
        tunnelU.position = CGPoint(x: -95, y: -168)
        tunnelU.physicsBody = SKPhysicsBody(circleOfRadius: 5)
        tunnelU.physicsBody?.isDynamic = false
        tunnelU.physicsBody?.categoryBitMask = tunnelUCategory
        addChild(tunnelU)
        
        // Launcher
        launcher.name = "Launcher"
        launcher.position = CGPoint(x: 155, y: -85)
        launcher.physicsBody = SKPhysicsBody(circleOfRadius: 5)
        launcher.physicsBody?.isDynamic = false
        launcher.physicsBody?.categoryBitMask = launcherCategory
        addChild(launcher)
        
        // Ball
        let ball = Ball(position: CGPoint(x: 0, y: 0), friction: ballFriction, restitution: ballRestitution, categoryBitMask: ballCategory, collisionBitMask: ballCategory | wallCategory | plungerCategory | targetCategory | slingshotCategory | bumperCategory | flipperCategory | removeBallCategory, contactTestBitMask: tunnelLCategory | tunnelUCategory | launcherCategory | lockPlungerCategory)
        balls.removeAll()
        ballCounter += 1
        addChild(ball)
        balls.append(ball)
        
        // Pinball Structure & Tunnels Foreground
        tunnelsFG.zPosition = CGFloat(0x1 << 10)
        tunnelsFG.position = positions
        addChild(tunnelsFG)
        
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
        if object.name == "TunnelL" {
        } else if object.name == "TunnelU" {
            ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            ball.run(SKAction.hide())
            self.run(SKAction.wait(forDuration: 1.5), completion: {
                ball.position = self.tunnelL.position
                ball.run(SKAction.sequence([SKAction.applyImpulse(CGVector(dx: 375, dy: 0), duration: 0.1), SKAction.unhide()]))
            })
        } else if object.name == "Launcher" {
            ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            self.run(SKAction.wait(forDuration: 1.5), completion: {
                ball.run(SKAction.applyImpulse(CGVector(dx: 0, dy: 2000), duration: 0.1))
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
    }
    
    open override func update(_ currentTime: TimeInterval) {
        if ballCollided && !ballCreation {
            ballCreation = true
            self.run(SKAction.wait(forDuration: 7), completion: { [self] in
                ballCounter -= 1
                balls[ballCounter].removeFromParent()
                balls.remove(at: ballCounter)
                let newBall = Ball(position: CGPoint(x: 0, y: 0), friction: ballFriction, restitution: ballRestitution, categoryBitMask: ballCategory, collisionBitMask: ballCategory | wallCategory | plungerCategory | targetCategory | slingshotCategory | bumperCategory | flipperCategory | removeBallCategory, contactTestBitMask: tunnelLCategory | tunnelUCategory | launcherCategory | lockPlungerCategory)
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

