import SpriteKit

open class Flipper: SKSpriteNode {
    
    var anchorPosition: CGPoint?
    var isRaised: Bool = false
    var lowerAngle: CGFloat?
    var upperAngle: CGFloat?
    var force: CGFloat = 1500
    
    init(anchorPosition: CGPoint, name: String, zRotation: CGFloat, restitution: CGFloat, categoryBitMask: UInt32, side: String) {
        let texture = SKTexture(imageNamed: "Flipper")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        self.name = name
        self.zRotation = degreesToRadians(zRotation)
        self.anchorPosition = anchorPosition
        self.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        self.physicsBody?.mass = 1000
        self.physicsBody?.isDynamic = false
        self.physicsBody?.restitution = restitution
        self.physicsBody?.categoryBitMask = categoryBitMask
        if side == "L"{
            lowerAngle = -30
            upperAngle = 30
        } else if side == "R" {
            lowerAngle = 30+180
            upperAngle = -30-180
            force *= -1
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func radiansToDegrees(_ radians: CGFloat) -> CGFloat {
        return radians * 180 / CGFloat.pi
    }
    
    func degreesToRadians(_ degrees: CGFloat) -> CGFloat {
        return degrees * CGFloat.pi / 180
    }
    
    open func createAnchor() -> SKNode {
        let flipperAnchor = SKNode()
        flipperAnchor.position = anchorPosition!
        flipperAnchor.physicsBody = SKPhysicsBody()
        flipperAnchor.physicsBody?.isDynamic = false
        return flipperAnchor
    }
    
    open func raise() {
        if isRaised == false {
            isRaised = true
            self.physicsBody?.isDynamic = true
            self.physicsBody?.applyAngularImpulse(force)
        }
    }
    
    open func lower() {
        self.physicsBody?.isDynamic = true
        self.physicsBody?.angularVelocity = 0
        let flip = SKAction.rotate(toAngle: degreesToRadians(lowerAngle!), duration: 0.1)
        let run = SKAction.run {
            self.lockFlipperDown()
        }
        self.run(SKAction.sequence([flip, run]), withKey: "LowerThenLock")
        isRaised = false
    }
    
    open func lockFlipperDown() {
        self.zRotation = degreesToRadians(lowerAngle!)
        lockFlipper()
    }
    
    open func lockFlipperUp() {
        self.zRotation = degreesToRadians(upperAngle!)
        lockFlipper()
    }
    
    open func lockFlipper() {
        self.physicsBody?.angularVelocity = 0
        self.physicsBody?.isDynamic = false
    }
}
