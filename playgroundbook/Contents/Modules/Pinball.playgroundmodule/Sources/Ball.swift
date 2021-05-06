import SpriteKit

open class Ball: SKSpriteNode {
    
    init(position: CGPoint, friction: CGFloat, restitution: CGFloat, categoryBitMask: UInt32, collisionBitMask: UInt32, contactTestBitMask: UInt32) {
        let texture = SKTexture(imageNamed: "Ball")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        self.setScale(0.5)
        self.zPosition = 1
        self.position = position
        self.physicsBody = SKPhysicsBody(circleOfRadius: 16)
        self.physicsBody?.mass = 1
        self.physicsBody?.friction = friction
        self.physicsBody?.restitution = restitution
        self.physicsBody?.categoryBitMask = categoryBitMask
        self.physicsBody?.collisionBitMask = collisionBitMask
        self.physicsBody?.contactTestBitMask = self.physicsBody!.collisionBitMask | contactTestBitMask
    }
    
    init() {
        let texture = SKTexture(imageNamed: "Ball")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
