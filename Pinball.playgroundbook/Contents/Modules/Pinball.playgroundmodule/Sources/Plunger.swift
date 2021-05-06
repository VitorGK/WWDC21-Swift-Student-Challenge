import SpriteKit

open class Plunger: SKSpriteNode {
    var tempY: CGFloat = 0
    var dY: CGFloat = 0
    var isMoving: Bool = false
    
    init(imageNamed: String, restitution: CGFloat, categoryBitMask: UInt32, collisionBitMask: UInt32) {
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        self.name = "Plunger"
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.texture!.size())
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.mass = 10000
        self.physicsBody?.restitution = restitution
        self.physicsBody?.categoryBitMask = categoryBitMask
        self.physicsBody?.collisionBitMask = collisionBitMask
        self.physicsBody?.contactTestBitMask = self.physicsBody!.collisionBitMask
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func chargePlunger() {
        tempY = -2
    }
    
    open func releasePlunger() {
        self.isMoving = true
        self.physicsBody?.isDynamic = true
        self.run(SKAction.applyImpulse(CGVector(dx: 0, dy: -dY*200000), duration: 0.1))
    }
    
    open func stopPlunger() {
        self.physicsBody?.isDynamic = false
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        self.position = CGPoint(x: 0, y: 0)
        self.isMoving = false
        self.tempY = 0
        self.dY = 0
    }
}
