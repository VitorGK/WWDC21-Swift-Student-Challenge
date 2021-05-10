import SpriteKit
//import AVFoundation

open class PinballScene: SKScene, SKPhysicsContactDelegate {
    
    // One-Shot Sounds
    var muteSounds: Bool = false
    let wallHitSound: [SKAction] = [SKAction.playSoundFileNamed("WallHitSound0.wav", waitForCompletion: false),
                                    SKAction.playSoundFileNamed("WallHitSound1.wav", waitForCompletion: false),
                                    SKAction.playSoundFileNamed("WallHitSound2.wav", waitForCompletion: false),
                                    SKAction.playSoundFileNamed("WallHitSound3.wav", waitForCompletion: false),
                                    SKAction.playSoundFileNamed("WallHitSound4.wav", waitForCompletion: false),
                                    SKAction.playSoundFileNamed("WallHitSound5.wav", waitForCompletion: false),
                                    SKAction.playSoundFileNamed("WallHitSound6.wav", waitForCompletion: false),
                                    SKAction.playSoundFileNamed("WallHitSound7.wav", waitForCompletion: false),
                                    SKAction.playSoundFileNamed("WallHitSound8.wav", waitForCompletion: false),
                                    SKAction.playSoundFileNamed("WallHitSound9.wav", waitForCompletion: false),
                                    SKAction.playSoundFileNamed("WallHitSound10.wav", waitForCompletion: false),
                                    SKAction.playSoundFileNamed("WallHitSound11.wav", waitForCompletion: false)]
    let ballHitSound: [SKAction] = [SKAction.playSoundFileNamed("BallHitSound0.wav", waitForCompletion: false),
                                    SKAction.playSoundFileNamed("BallHitSound1.wav", waitForCompletion: false),
                                    SKAction.playSoundFileNamed("BallHitSound2.wav", waitForCompletion: false),
                                    SKAction.playSoundFileNamed("BallHitSound3.wav", waitForCompletion: false)]
    let rubberHitSound: [SKAction] = [SKAction.playSoundFileNamed("RubberHitSound0.wav", waitForCompletion: false),
                                      SKAction.playSoundFileNamed("RubberHitSound1.wav", waitForCompletion: false),
                                      SKAction.playSoundFileNamed("RubberHitSound2.wav", waitForCompletion: false),
                                      SKAction.playSoundFileNamed("RuuberHitSound3.wav", waitForCompletion: false)]
    let flipperOpenSound: SKAction = SKAction.playSoundFileNamed("FlipperOpenSound.wav", waitForCompletion: false)
    let flipperCloseSound: SKAction = SKAction.playSoundFileNamed("FlipperCloseSound.wav", waitForCompletion: false)
    let plungerReleaseSound: SKAction = SKAction.playSoundFileNamed("PlungerReleaseSound.wav", waitForCompletion: false)
    let targetLHitSound: SKAction = SKAction.playSoundFileNamed("TargetLHitSound.wav", waitForCompletion: false)
    let targetUHitSound: SKAction = SKAction.playSoundFileNamed("TargetUHitSound.wav", waitForCompletion: false)
    let bumperHitSound: SKAction = SKAction.playSoundFileNamed("BumperHitSound.wav", waitForCompletion: false)
    let slingshotSound: SKAction = SKAction.playSoundFileNamed("SlingshotSound.wav", waitForCompletion: false)
    let ballDrainSound: [SKAction] = [SKAction.playSoundFileNamed("BallDrainSound0.wav", waitForCompletion: false),
                                      SKAction.playSoundFileNamed("BallDrainSound1.wav", waitForCompletion: false),
                                      SKAction.playSoundFileNamed("BallDrainSound2.wav", waitForCompletion: false),
                                      SKAction.playSoundFileNamed("BallDrainSound3.wav", waitForCompletion: false),
                                      SKAction.playSoundFileNamed("BallDrainSound4.wav", waitForCompletion: false)]
    let newBallSound: SKAction = SKAction.playSoundFileNamed("NewBallSound.wav", waitForCompletion: false)
    let coinInSound: SKAction = SKAction.playSoundFileNamed("CoinInSound.wav", waitForCompletion: false)
    
    // Long Sounds
    let plungerChargeSound: SKAudioNode = SKAudioNode(fileNamed: "PlungerChargeSound.wav")
    let tunnelSound: SKAudioNode = SKAudioNode(fileNamed: "TunnelSound.wav")
    let launcherSound: SKAudioNode = SKAudioNode(fileNamed: "LauncherSound.wav")
    let gameOverSound: SKAudioNode = SKAudioNode(fileNamed: "GameOverSound.wav")
    
    // Music
    var muteMusic: Bool = false
    var firstPlay: Bool = true
    let gameMusic: SKAudioNode = SKAudioNode(fileNamed: "GameMusic.wav")
    
    // Scores
    var playerScore: Int = 0
    var playerHighscore: Int = 0
    let initMultiplier: Int = 1
    let multiplierIncrement: Int = 1
    var multiplier: Int!
    let maxMultiplier: Int = 50
    var newHighscore: Bool = false
    
    let bumperScore: Int = 1
    let tunnelScore: Int = 25
    let targetLScore: Int = 100
    let launcherScore: Int = 250
    let targetUScore: Int = 500
    
    var playerLifes: Int = 3
    
    // Labels
    let playerScoreLabel = SKLabelNode()
    var playerScoreText: String!
    var playerScoreRange: NSRange!
    var playerScoreString: NSMutableAttributedString!
    let playerHighscoreLabel = SKLabelNode()
    var playerHighscoreText: String!
    var playerHighscoreRange: NSRange!
    var playerHighscoreString: NSMutableAttributedString!
    let multiplierLabel = SKLabelNode()
    var multiplierText: String!
    var multiplierRange: NSRange!
    var multiplierString: NSMutableAttributedString!
    let textColor = UIColor(red: 190, green: 86, blue: 77, alpha: 1)
    let textFont = UIFont.monospacedSystemFont(ofSize: 23.75, weight: .bold)
    let startLabel = SKLabelNode()
    let gameOverLabel = SKLabelNode()
    let scoreLabel = SKLabelNode()
    let highscoreLabel = SKLabelNode()
    let restartLabel = SKLabelNode()
    let gameOverScoreLabel = SKLabelNode()
    let gameOverHighscoreLabel = SKLabelNode()
    let newScoreLabel = SKLabelNode()
    let newHighscoreLabel = SKLabelNode()
    let buttonColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
    let startColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
    
    // Masks Categories
    let ballCategory: UInt32 = 1 << 1
    let flipperCategory: UInt32 = 1 << 2
    let bumperCategory: UInt32 = 1 << 3
    let slingshotCategory: UInt32 = 1 << 4
    let targetCategory: UInt32 = 1 << 5
    let plungerCategory: UInt32 = 1 << 6
    let wallCategory: UInt32 = 1 << 7
    let lockCategory: UInt32 = 1 << 8
    let tunnelLCategory: UInt32 = 1 << 9
    let tunnelUCategory: UInt32 = 1 << 10
    let launcherCategory: UInt32 = 1 << 11
    let lockPlungerCategory: UInt32 = 1 << 12
    let removeBallCategory: UInt32 = 1 << 13
    let rampInBlockerCategory: UInt32 = 1 << 14
    let targetUBlockerCategory: UInt32 = 1 << 15
    
    // Pinball Physics
    let ballRestitution: CGFloat = 0.3
    let wallRestitution: CGFloat = 0.1
    let targetRestitution: CGFloat = 0.2
    let plungerRestitution: CGFloat = 0.2
    let slingshotRestitution: CGFloat = 0.5
    let slingshotBRestitution: CGFloat = 0.2
    let bumperRestitution: CGFloat = 0.5
    let flipperRestitution: CGFloat = 0.4
    
    let slingshotFriction: CGFloat = 0.9
    let bumperFriction: CGFloat = 0.5
    let ballFriction: CGFloat = 0.05
    let flipperFriction: CGFloat = 0.9
    
    // Textures
    let targetLTextures: [SKTexture] = [SKTexture(imageNamed: "TargetL0"),
                                        SKTexture(imageNamed: "TargetL1")]
    let targetUTextures: [SKTexture] = [SKTexture(imageNamed: "TargetU0"),
                                        SKTexture(imageNamed: "TargetU1")]
    let slingshotLTextures: [SKTexture] = [SKTexture(imageNamed: "SlingshotLN"),
                                           SKTexture(imageNamed: "SlingshotLO"),
                                           SKTexture(imageNamed: "SlingshotLB")]
    let slingshotRTextures: [SKTexture] = [SKTexture(imageNamed: "SlingshotRN"),
                                           SKTexture(imageNamed: "SlingshotRO"),
                                           SKTexture(imageNamed: "SlingshotRB")]
    let bumperLTextures: [SKTexture] = [SKTexture(imageNamed: "BumperLN"),
                                        SKTexture(imageNamed: "BumperLC")]
    let bumperR0Textures: [SKTexture] = [SKTexture(imageNamed: "BumperR0N"),
                                         SKTexture(imageNamed: "BumperR0C")]
    let bumperR1Textures: [SKTexture] = [SKTexture(imageNamed: "BumperR1N"),
                                         SKTexture(imageNamed: "BumperR1C")]
    let bumperR2Textures: [SKTexture] = [SKTexture(imageNamed: "BumperR2N"),
                                         SKTexture(imageNamed: "BumperR2C")]
    let tunnelArrowTextures: [SKTexture] = [SKTexture(imageNamed: "TunnelArrow0"),
                                            SKTexture(imageNamed: "TunnelArrow1")]
    let rampInBlockerTextures: [SKTexture] = [SKTexture(imageNamed: "RampInBlocker0"),
                                              SKTexture(imageNamed: "RampInBlocker1")]
    let targetUBlockerTextures: [SKTexture] = [SKTexture(imageNamed: "TargetUBlocker0"),
                                               SKTexture(imageNamed: "TargetUBlocker1")]
    let muteSoundsButtonTextures: [SKTexture] = [SKTexture(imageNamed: "MuteSoundsButton0"),
                                                SKTexture(imageNamed: "MuteSoundsButton1")]
    let muteMusicButtonTextures: [SKTexture] = [SKTexture(imageNamed: "MuteMusicButton0"),
                                                SKTexture(imageNamed: "MuteMusicButton1")]
    let ballTextures: [SKTexture] = [SKTexture(imageNamed: "Ball"),
                                     SKTexture(imageNamed: "BallDark")]
    
    // Pinball Parts
    let pinballBG = SKSpriteNode(imageNamed: "PinballBG")
    let plusBall = SKSpriteNode(imageNamed: "PlusBall")
    let pinballStructure0 = SKSpriteNode(imageNamed: "PinballStructure0")
    let pinballStructure1 = SKSpriteNode(imageNamed: "PinballStructure1")
    let pinballStructure2 = SKSpriteNode(imageNamed: "PinballStructure2")
    let rampIn0 = SKSpriteNode(imageNamed: "RampIn0")
    let rampIn1 = SKSpriteNode(imageNamed: "RampIn1")
    let rampIn2 = SKSpriteNode(imageNamed: "RampIn2")
    let rampInBlocker = SKSpriteNode(imageNamed: "RampInBlocker0")
    let targetL = SKSpriteNode(imageNamed: "TargetL0")
    let targetU = SKSpriteNode(imageNamed: "TargetU0")
    let targetUBlocker = SKSpriteNode(imageNamed: "TargetUBlocker0")
    let obstacle0 = SKSpriteNode(imageNamed: "Obstacle0")
    let obstacle1 = SKSpriteNode(imageNamed: "Obstacle1")
    let obstacle2 = SKSpriteNode(imageNamed: "Obstacle2")
    let obstacle3 = SKSpriteNode(imageNamed: "Obstacle3")
    var plunger: Plunger?
    let plungerActivator = SKShapeNode(rect: CGRect(x: 295, y: -500, width: 80, height: 250))
    let slingshotL = SKSpriteNode(imageNamed: "SlingshotLN")
    let slingshotLB = SKSpriteNode(imageNamed: "SlingshotLB")
    let slingshotR = SKSpriteNode(imageNamed: "SlingshotRN")
    let slingshotRB = SKSpriteNode(imageNamed: "SlingshotRB")
    let bumperL = SKSpriteNode(imageNamed: "BumperLN")
    let bumperR0 = SKSpriteNode(imageNamed: "BumperR0N")
    let bumperR1 = SKSpriteNode(imageNamed: "BumperR1N")
    let bumperR2 = SKSpriteNode(imageNamed: "BumperR2N")
    let tunnelsFG = SKSpriteNode(imageNamed: "TunnelsFG")
    let tunnelsBG = SKSpriteNode(imageNamed: "TunnelsBG")
    let tunnelArrow = SKSpriteNode(imageNamed: "TunnelArrow0")
    var flipperLeft: Flipper?
    var flipperRight: Flipper?
    let flipperLocker = SKShapeNode(rect: CGRect(x: -200, y: -220, width: 400, height: 100))
    var ball: Ball = Ball()
    var ballCounter: Int = 0
    var maxBalls: Int = 4
//    var balls: [String: Ball] = [:]
    let scoreScreen = SKSpriteNode(imageNamed: "ScoreScreen")
    let ballLifes: [SKSpriteNode] = [SKSpriteNode(imageNamed: "Ball"),
                                     SKSpriteNode(imageNamed: "Ball"),
                                     SKSpriteNode(imageNamed: "Ball")]
    
    // Buttons
    let muteSoundsButton = SKSpriteNode(imageNamed: "MuteSoundsButton0")
    let muteMusicButton = SKSpriteNode(imageNamed: "MuteMusicButton0")
    let startButton = SKShapeNode(rectOf: CGSize(width: 225, height: 100), cornerRadius: 25)
    let restartButton = SKShapeNode(rectOf: CGSize(width: 500, height: 100), cornerRadius: 25)
    
    // Foreground & Background
    var foregroundMenu = SKShapeNode(circleOfRadius: 1000)
    let scoreBackground = SKShapeNode(rectOf: CGSize(width: 550, height: 130), cornerRadius: 25)
    
    // Notificators
    let tunnelL = SKNode()
    let tunnelU = SKNode()
    let launcher = SKNode()
    let lockPlunger = SKNode()
    
    // Lockers
    var plungerLocked: Bool = false
    var isBeingLaunched: Bool = false
    var ballInGame: Bool = false
    var gameStarted: Bool = false
    
    open override func didMove(to view: SKView) {
        super.didMove(to: view)
        backgroundColor = UIColor.init(white: 0.125, alpha: 1)
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -5)
        multiplier = initMultiplier
        
        // Sounds
        plungerChargeSound.name = "Sounds"
        tunnelSound.name = "Sounds"
        launcherSound.name = "Sounds"
        gameOverSound.name = "Sounds"
        plungerChargeSound.autoplayLooped = false
        tunnelSound.autoplayLooped = false
        launcherSound.autoplayLooped = false
        gameOverSound.autoplayLooped = false
        addChild(plungerChargeSound)
        addChild(tunnelSound)
        addChild(launcherSound)
        addChild(gameOverSound)
        
        // Music
        gameMusic.autoplayLooped = false
        addChild(gameMusic)
        gameMusic.autoplayLooped = true
        
        // PinballBG
        pinballBG.zPosition = 0
        addChild(pinballBG)
        
        // TunnelArrow
        addChild(tunnelArrow)
        
        // Target Left
        targetL.name = "TargetL"
        targetL.physicsBody = SKPhysicsBody(texture: targetLTextures[0], size: targetLTextures[0].size())
        targetL.physicsBody?.isDynamic = false
        targetL.physicsBody?.restitution = targetRestitution
        targetL.physicsBody?.categoryBitMask = targetCategory
        addChild(targetL)
        
        // Target Upper
        targetU.name = "TargetU"
        targetU.physicsBody = SKPhysicsBody(texture: targetUTextures[0], size: targetUTextures[0].size())
        targetU.physicsBody?.isDynamic = false
        targetU.physicsBody?.restitution = targetRestitution
        targetU.physicsBody?.categoryBitMask = targetCategory
        addChild(targetU)
        
        // Target Upper Blocker
        targetUBlocker.name = "Blocker"
        targetUBlocker.physicsBody = SKPhysicsBody(texture: targetUBlocker.texture!, size: targetUBlocker.texture!.size())
        targetUBlocker.physicsBody?.isDynamic = false
        targetUBlocker.physicsBody?.restitution = 0
        targetUBlocker.physicsBody?.friction = 0
        targetUBlocker.physicsBody?.categoryBitMask = targetUBlockerCategory
        addChild(targetUBlocker)
        
        // PlusBall
        addChild(plusBall)
        
        // Pinball Structure
        pinballStructure0.name = "Structure"
        pinballStructure0.physicsBody = SKPhysicsBody(texture: pinballStructure0.texture!, alphaThreshold: 0.9, size: pinballStructure0.texture!.size())
        pinballStructure0.physicsBody?.isDynamic = false
        pinballStructure0.physicsBody?.restitution = wallRestitution
        pinballStructure0.physicsBody?.categoryBitMask = wallCategory
        addChild(pinballStructure0)
        
        pinballStructure1.name = "Structure"
        pinballStructure1.physicsBody = SKPhysicsBody(texture: pinballStructure1.texture!, alphaThreshold: 0.9, size: pinballStructure1.texture!.size())
        pinballStructure1.physicsBody?.isDynamic = false
        pinballStructure1.physicsBody?.restitution = wallRestitution
        pinballStructure1.physicsBody?.categoryBitMask = wallCategory
        addChild(pinballStructure1)
        
        // Ball Ramp In
        rampIn0.name = "RampIn"
        rampIn0.physicsBody = SKPhysicsBody(texture: rampIn0.texture!, alphaThreshold: 0.9, size: rampIn0.texture!.size())
        rampIn0.physicsBody?.isDynamic = false
        rampIn0.physicsBody?.restitution = 0
        rampIn0.physicsBody?.friction = 0.025
        rampIn0.physicsBody?.categoryBitMask = wallCategory
        addChild(rampIn0)
        
        rampIn1.name = "RampIn"
        rampIn1.physicsBody = SKPhysicsBody(texture: rampIn1.texture!, alphaThreshold: 0.9, size: rampIn1.texture!.size())
        rampIn1.physicsBody?.isDynamic = false
        rampIn1.physicsBody?.restitution = 0
        rampIn1.physicsBody?.friction = 0.025
        rampIn1.physicsBody?.categoryBitMask = wallCategory
        addChild(rampIn1)
        
        rampIn2.name = "RampIn"
        rampIn2.physicsBody = SKPhysicsBody(texture: rampIn2.texture!, alphaThreshold: 0.9, size: rampIn2.texture!.size())
        rampIn2.physicsBody?.isDynamic = false
        rampIn2.physicsBody?.restitution = 0
        rampIn2.physicsBody?.friction = 0.025
        rampIn2.physicsBody?.categoryBitMask = wallCategory
        addChild(rampIn2)
        
        // Ball Ramp In Blocker
        rampInBlocker.name = "Blocker"
        rampInBlocker.physicsBody = SKPhysicsBody(texture: rampInBlocker.texture!, size: rampInBlocker.texture!.size())
        rampInBlocker.physicsBody?.isDynamic = false
        rampInBlocker.physicsBody?.restitution = 0
        rampInBlocker.physicsBody?.friction = 0
        rampInBlocker.physicsBody?.categoryBitMask = rampInBlockerCategory
        addChild(rampInBlocker)
        
        // Obstacles
        obstacle0.name = "Obstacle"
        obstacle0.physicsBody = SKPhysicsBody(texture: obstacle0.texture!, alphaThreshold: 0.9, size: obstacle0.texture!.size())
        obstacle0.physicsBody?.isDynamic = false
        obstacle0.physicsBody?.restitution = wallRestitution
        obstacle0.physicsBody?.categoryBitMask = wallCategory
        addChild(obstacle0)
        
        obstacle1.name = "Obstacle"
        obstacle1.physicsBody = SKPhysicsBody(texture: obstacle1.texture!, alphaThreshold: 0.9, size: obstacle1.texture!.size())
        obstacle1.physicsBody?.isDynamic = false
        obstacle1.physicsBody?.restitution = wallRestitution
        obstacle1.physicsBody?.categoryBitMask = wallCategory
        addChild(obstacle1)
        
        obstacle2.name = "Obstacle"
        obstacle2.physicsBody = SKPhysicsBody(texture: obstacle2.texture!, alphaThreshold: 0.9, size: obstacle2.texture!.size())
        obstacle2.physicsBody?.isDynamic = false
        obstacle2.physicsBody?.restitution = wallRestitution
        obstacle2.physicsBody?.categoryBitMask = wallCategory
        addChild(obstacle2)
        
        obstacle3.name = "Obstacle"
        obstacle3.physicsBody = SKPhysicsBody(texture: obstacle3.texture!, alphaThreshold: 0.9, size: obstacle3.texture!.size())
        obstacle3.physicsBody?.isDynamic = false
        obstacle3.physicsBody?.restitution = wallRestitution
        obstacle3.physicsBody?.categoryBitMask = wallCategory
        addChild(obstacle3)
        
        // Plunger
        plunger = Plunger(imageNamed: "Plunger", restitution: plungerRestitution, categoryBitMask: plungerCategory, collisionBitMask: wallCategory)
        addChild(plunger!)
        
        // Slingshot Left
        slingshotL.name = "SlingshotL"
        slingshotL.physicsBody = SKPhysicsBody(texture: slingshotLTextures[0], size: slingshotLTextures[0].size())
        slingshotL.physicsBody?.isDynamic = false
        slingshotL.physicsBody?.friction = slingshotFriction
        slingshotL.physicsBody?.restitution = slingshotRestitution
        slingshotL.physicsBody?.categoryBitMask = slingshotCategory
        addChild(slingshotL)
        
        // Slingshot Left Body
        slingshotLB.name = "SlingshotBody"
        slingshotLB.physicsBody = SKPhysicsBody(texture: slingshotLTextures[2], size: slingshotLTextures[2].size())
        slingshotLB.physicsBody?.isDynamic = false
        slingshotLB.physicsBody?.friction = slingshotFriction
        slingshotLB.physicsBody?.restitution = slingshotBRestitution
        slingshotLB.physicsBody?.categoryBitMask = slingshotCategory
        addChild(slingshotLB)
        
        // Slingshot Right
        slingshotR.name = "SlingshotR"
        slingshotR.physicsBody = SKPhysicsBody(texture: slingshotRTextures[0], size: slingshotRTextures[0].size())
        slingshotR.physicsBody?.isDynamic = false
        slingshotR.physicsBody?.friction = slingshotFriction
        slingshotR.physicsBody?.restitution = slingshotRestitution
        slingshotR.physicsBody?.categoryBitMask = slingshotCategory
        addChild(slingshotR)
        
        // Slingshot Right Body
        slingshotRB.name = "SlingshotBody"
        slingshotRB.physicsBody = SKPhysicsBody(texture: slingshotRTextures[2], size: slingshotRTextures[2].size())
        slingshotRB.physicsBody?.isDynamic = false
        slingshotRB.physicsBody?.friction = slingshotFriction
        slingshotRB.physicsBody?.restitution = slingshotBRestitution
        slingshotRB.physicsBody?.categoryBitMask = slingshotCategory
        addChild(slingshotRB)
        
        // Bumper Left
        bumperL.name = "BumperL"
        bumperL.physicsBody = SKPhysicsBody(texture: bumperLTextures[0], size: bumperLTextures[1].size())
        bumperL.physicsBody?.isDynamic = false
        bumperL.physicsBody?.restitution = bumperRestitution
        bumperL.physicsBody?.friction = bumperFriction
        bumperL.physicsBody?.categoryBitMask = bumperCategory
        addChild(bumperL)
        
        // Bumper Right 0
        bumperR0.name = "BumperR0"
        bumperR0.physicsBody = SKPhysicsBody(texture: bumperR0Textures[0], size: bumperR0Textures[1].size())
        bumperR0.physicsBody?.isDynamic = false
        bumperR0.physicsBody?.restitution = bumperRestitution
        bumperL.physicsBody?.friction = bumperFriction
        bumperR0.physicsBody?.categoryBitMask = bumperCategory
        addChild(bumperR0)
        
        // Bumper Right 1
        bumperR1.name = "BumperR1"
        bumperR1.physicsBody = SKPhysicsBody(texture: bumperR1Textures[0], size: bumperR1Textures[1].size())
        bumperR1.physicsBody?.isDynamic = false
        bumperR1.physicsBody?.restitution = bumperRestitution
        bumperL.physicsBody?.friction = bumperFriction
        bumperR1.physicsBody?.categoryBitMask = bumperCategory
        addChild(bumperR1)
        
        // Bumper Right 2
        bumperR2.name = "BumperR2"
        bumperR2.physicsBody = SKPhysicsBody(texture: bumperR2Textures[0], size: bumperR2Textures[1].size())
        bumperR2.physicsBody?.isDynamic = false
        bumperR2.physicsBody?.restitution = bumperRestitution
        bumperL.physicsBody?.friction = bumperFriction
        bumperR2.physicsBody?.categoryBitMask = bumperCategory
        addChild(bumperR2)
        
        // Tunnels Background
        tunnelsBG.zPosition = 0
        addChild(tunnelsBG)
        
        // Tunnel Left
        tunnelL.name = "TunnelL"
        tunnelL.position = CGPoint(x: -360, y: 211)
        tunnelL.physicsBody = SKPhysicsBody(circleOfRadius: 5)
        tunnelL.physicsBody?.isDynamic = false
        tunnelL.physicsBody?.categoryBitMask = tunnelLCategory
        addChild(tunnelL)
        
        // Tunnel Upper
        tunnelU.name = "TunnelU"
        tunnelU.position = CGPoint(x: -81, y: 295)
        tunnelU.physicsBody = SKPhysicsBody(circleOfRadius: 3)
        tunnelU.physicsBody?.isDynamic = false
        tunnelU.physicsBody?.categoryBitMask = tunnelUCategory
        addChild(tunnelU)
        
        // Launcher
        launcher.name = "Launcher"
        launcher.position = CGPoint(x: -300, y: -25)
        launcher.physicsBody = SKPhysicsBody(circleOfRadius: 5)
        launcher.physicsBody?.isDynamic = false
        launcher.physicsBody?.categoryBitMask = launcherCategory
        addChild(launcher)
        
        // Flipper Left
        flipperLeft = Flipper(anchorPosition: CGPoint(x: -138, y: -273), name: "FlipperL", zRotation: -30, restitution: flipperRestitution, friction: flipperFriction, categoryBitMask: flipperCategory, side: "L")
        flipperLeft!.physicsBody?.collisionBitMask = lockCategory
        flipperLeft!.physicsBody?.contactTestBitMask = flipperLeft!.physicsBody!.collisionBitMask
        guard let flipperLeftAnchor = flipperLeft?.createAnchor() else { return }
        addChild(flipperLeftAnchor)
        flipperLeftAnchor.addChild(flipperLeft!)
        let flipperLeftJoint = SKPhysicsJointPin.joint(withBodyA: flipperLeftAnchor.physicsBody!, bodyB: flipperLeft!.physicsBody!, anchor: flipperLeftAnchor.position)
        physicsWorld.add(flipperLeftJoint)
        
        // Flipper Right
        flipperRight = Flipper(anchorPosition: CGPoint(x: 70.5, y: -273), name: "FlipperR", zRotation: 210, restitution: flipperRestitution, friction: flipperFriction, categoryBitMask: flipperCategory, side: "R")
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
        flipperLocker.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: -180, y: -215, width: 300, height: 50))
        flipperLocker.physicsBody?.isDynamic = false
        flipperLocker.physicsBody?.categoryBitMask = lockCategory
        addChild(flipperLocker)
        
        // Lock Plunger Notificator
        lockPlunger.name = "lockPlunger"
        lockPlunger.position = CGPoint(x: -200, y: 410)
        lockPlunger.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        lockPlunger.physicsBody?.isDynamic = false
        lockPlunger.physicsBody?.categoryBitMask = lockPlungerCategory
        addChild(lockPlunger)
        
        // Pinball Structure & Tunnels Foreground
        pinballStructure2.name = "Remove"
        pinballStructure2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 10), center: CGPoint(x: -35, y: -415))
        pinballStructure2.physicsBody?.isDynamic = false
        pinballStructure2.physicsBody?.categoryBitMask = removeBallCategory
        pinballStructure2.zPosition = CGFloat(1 << 10)
        addChild(pinballStructure2)
        
        tunnelsFG.zPosition = CGFloat(1 << 10)
        addChild(tunnelsFG)
        
        // Plunger Activator
        plungerActivator.name = "PlungerActivator"
        plungerActivator.lineWidth = 0
        addChild(plungerActivator)
        
        // Mute Sounds Button
        muteSoundsButton.name = "MuteSoundsButton"
        muteSoundsButton.setScale(0.25)
        muteSoundsButton.position = CGPoint(x: 320, y: 410)
        muteSoundsButton.zPosition = CGFloat(1 << 12)
        addChild(muteSoundsButton)
        
        // Mute Music Button
        muteMusicButton.name = "MuteMusicButton"
        muteMusicButton.setScale(0.25)
        muteMusicButton.position = CGPoint(x: -320, y: 410)
        muteMusicButton.zPosition = CGFloat(1 << 12)
        addChild(muteMusicButton)
        
        // Ball Lifes
        ballLifes[0].setScale(0.75)
        ballLifes[0].position = CGPoint(x: 161, y: -370)
        ballLifes[1].setScale(0.75)
        ballLifes[1].position = CGPoint(x: 216, y: -370)
        ballLifes[2].setScale(0.75)
        ballLifes[2].position = CGPoint(x: 271, y: -370)
        addChild(ballLifes[0])
        addChild(ballLifes[1])
        addChild(ballLifes[2])
        
        // Score Screen
        scoreScreen.zPosition = CGFloat(1 << 10)
        addChild(scoreScreen)
        
        // Score Text
        playerScoreText = String(playerScore)
        playerScoreRange = NSRange(location: 0, length: playerScoreText.count)
        playerScoreString = NSMutableAttributedString(string: playerScoreText)
        playerScoreString.addAttributes([NSAttributedString.Key.foregroundColor: textColor,
                                         NSAttributedString.Key.font: textFont],
                                        range: playerScoreRange)
        playerScoreLabel.attributedText = playerScoreString
        playerScoreLabel.numberOfLines = 1
        playerScoreLabel.horizontalAlignmentMode = .right
        playerScoreLabel.verticalAlignmentMode = .bottom
        playerScoreLabel.position = CGPoint(x: -238, y: -354.5)
        playerScoreLabel.zPosition = CGFloat(1 << 10)
        addChild(playerScoreLabel)
        
        // Highscore
        playerHighscoreText = String(playerHighscore)
        playerHighscoreRange = NSRange(location: 0, length: playerHighscoreText.count)
        playerHighscoreString = NSMutableAttributedString(string: playerHighscoreText)
        playerHighscoreString.addAttributes([NSAttributedString.Key.foregroundColor: textColor,
                                             NSAttributedString.Key.font: textFont],
                                            range: playerHighscoreRange)
        playerHighscoreLabel.attributedText = playerHighscoreString
        playerHighscoreLabel.numberOfLines = 1
        playerHighscoreLabel.horizontalAlignmentMode = .right
        playerHighscoreLabel.verticalAlignmentMode = .bottom
        playerHighscoreLabel.position = CGPoint(x: -238, y: -386)
        playerHighscoreLabel.zPosition = CGFloat(1 << 10)
        addChild(playerHighscoreLabel)
        
        // Multiplier
        multiplierText = String(multiplier)
        multiplierRange = NSRange(location: 0, length: multiplierText.count)
        multiplierString = NSMutableAttributedString(string: multiplierText)
        multiplierString.addAttributes([NSAttributedString.Key.foregroundColor: textColor,
                                        NSAttributedString.Key.font: textFont],
                                       range: multiplierRange)
        multiplierLabel.attributedText = multiplierString
        multiplierLabel.numberOfLines = 1
        multiplierLabel.horizontalAlignmentMode = .right
        multiplierLabel.verticalAlignmentMode = .bottom
        multiplierLabel.position = CGPoint(x: -327, y: -322)
        multiplierLabel.zPosition = CGFloat(1 << 10)
        addChild(multiplierLabel)
        
        // Start
        foregroundMenu.fillColor = .black
        foregroundMenu.alpha = 0.75
        foregroundMenu.zPosition = CGFloat(1 << 11)
        addChild(foregroundMenu)
        startButton.name = "Start"
        startButton.lineWidth = 0
        startButton.fillColor = buttonColor
        startButton.position = CGPoint(x: 0, y: 15)
        startButton.zPosition = CGFloat(1 << 12)
        addChild(startButton)
        let startFont = UIFont.monospacedSystemFont(ofSize: 75, weight: .bold)
        var startText = "PLAY"
        var startRange = NSRange(location: 0, length: startText.count)
        var startString = NSMutableAttributedString(string: startText)
        startString.addAttributes([NSAttributedString.Key.foregroundColor: startColor,
                                   NSAttributedString.Key.font: startFont],
                                  range: startRange)
        startLabel.attributedText = startString
        startLabel.numberOfLines = 1
        startLabel.horizontalAlignmentMode = .center
        startLabel.verticalAlignmentMode = .center
        startLabel.position = CGPoint(x: 0, y: 0)
        startLabel.zPosition = CGFloat(1 << 12)
        startButton.addChild(startLabel)
    }
    
    open override func didChangeSize(_ oldSize: CGSize) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    func updateScore(objectScore: Int, multiplier: Int) {
        playerScore += objectScore * multiplier
        if playerScore > playerHighscore {
            newHighscore = true
            playerHighscore = playerScore
        }
        
        if playerScore > 99999999 {
            // Score
            playerScoreText = "AWESOME!"
            playerScoreRange = NSRange(location: 0, length: playerScoreText.count)
            playerScoreString = NSMutableAttributedString(string: playerScoreText)
            playerScoreString.addAttributes([NSAttributedString.Key.foregroundColor: textColor,
                                             NSAttributedString.Key.font: textFont],
                                            range: playerScoreRange)
            playerScoreLabel.attributedText = playerScoreString
            
            // Highscore
            playerHighscoreText = "AWESOME!"
            playerHighscoreRange = NSRange(location: 0, length: playerHighscoreText.count)
            playerHighscoreString = NSMutableAttributedString(string: playerHighscoreText)
            playerHighscoreString.addAttributes([NSAttributedString.Key.foregroundColor: textColor,
                                                 NSAttributedString.Key.font: textFont],
                                                range: playerHighscoreRange)
            playerHighscoreLabel.attributedText = playerHighscoreString
        } else {
            // Score
            playerScoreText = String(playerScore)
            playerScoreRange = NSRange(location: 0, length: playerScoreText.count)
            playerScoreString = NSMutableAttributedString(string: playerScoreText)
            playerScoreString.addAttributes([NSAttributedString.Key.foregroundColor: textColor,
                                             NSAttributedString.Key.font: textFont],
                                            range: playerScoreRange)
            playerScoreLabel.attributedText = playerScoreString
            
            // Highscore
            playerHighscoreText = String(playerHighscore)
            playerHighscoreRange = NSRange(location: 0, length: playerHighscoreText.count)
            playerHighscoreString = NSMutableAttributedString(string: playerHighscoreText)
            playerHighscoreString.addAttributes([NSAttributedString.Key.foregroundColor: textColor,
                                                 NSAttributedString.Key.font: textFont],
                                                range: playerHighscoreRange)
            playerHighscoreLabel.attributedText = playerHighscoreString
        }
    }
    
    func collision(between ball: SKNode, object: SKNode) {
        switch object.name {
        case "SlingshotL":
            slingshotL.run(SKAction.animate(with: [slingshotLTextures[1], slingshotLTextures[0]], timePerFrame: 0.1))
            if !muteSounds {
                object.run(slingshotSound)
            }
            ball.physicsBody!.velocity.dx += 400
            ball.physicsBody!.velocity.dy += 300
        case "SlingshotR":
            slingshotR.run(SKAction.animate(with: [slingshotRTextures[1], slingshotRTextures[0]], timePerFrame: 0.1))
            if !muteSounds {
                object.run(slingshotSound)
            }
            ball.physicsBody!.velocity.dx += -400
            ball.physicsBody!.velocity.dy += 300
        case "BumperL":
            bumperL.run(SKAction.animate(with: bumperLTextures.reversed(), timePerFrame: 0.1))
            if !muteSounds {
                object.run(bumperHitSound)
            }
            ball.physicsBody?.velocity.dx += 250 * (ball.physicsBody!.velocity.dx < 0 ? -1 : 1)
            ball.physicsBody?.velocity.dy += 250 * (ball.physicsBody!.velocity.dy < 0 ? -1 : 1)
            updateScore(objectScore: bumperScore, multiplier: multiplier)
        case "BumperR0":
            bumperR0.run(SKAction.animate(with: bumperR0Textures.reversed(), timePerFrame: 0.1))
            if !muteSounds {
                object.run(bumperHitSound)
            }
            ball.physicsBody?.velocity.dx += 250 * (ball.physicsBody!.velocity.dx < 0 ? -1 : 1)
            ball.physicsBody?.velocity.dy += 250 * (ball.physicsBody!.velocity.dy < 0 ? -1 : 1)
            updateScore(objectScore: bumperScore, multiplier: multiplier)
        case "BumperR1":
            bumperR1.run(SKAction.animate(with: bumperR1Textures.reversed(), timePerFrame: 0.1))
            if !muteSounds {
                object.run(bumperHitSound)
            }
            ball.physicsBody?.velocity.dx += 250 * (ball.physicsBody!.velocity.dx < 0 ? -1 : 1)
            ball.physicsBody?.velocity.dy += 250 * (ball.physicsBody!.velocity.dy < 0 ? -1 : 1)
            updateScore(objectScore: bumperScore, multiplier: multiplier)
        case "BumperR2":
            bumperR2.run(SKAction.animate(with: bumperR2Textures.reversed(), timePerFrame: 0.1))
            if !muteSounds {
                object.run(bumperHitSound)
            }
            ball.physicsBody?.velocity.dx += 250 * (ball.physicsBody!.velocity.dx < 0 ? -1 : 1)
            ball.physicsBody?.velocity.dy += 250 * (ball.physicsBody!.velocity.dy < 0 ? -1 : 1)
            updateScore(objectScore: bumperScore, multiplier: multiplier)
        case "TargetL":
            targetL.run(SKAction.animate(with: targetLTextures.reversed(), timePerFrame: 0.2))
            if !muteSounds {
                object.run(targetLHitSound)
            }
            ball.physicsBody?.velocity.dx += 300
            ball.physicsBody?.velocity.dy += -500
            updateScore(objectScore: targetLScore, multiplier: multiplier)
        case "TargetU":
            targetU.run(SKAction.animate(with: targetUTextures.reversed(), timePerFrame: 0.2))
            if !muteSounds {
                object.run(targetUHitSound)
            }
            updateScore(objectScore: targetUScore, multiplier: multiplier)
            multiplier += multiplierIncrement
            multiplierText = String(multiplier)
            multiplierRange = NSRange(location: 0, length: multiplierText.count)
            multiplierString = NSMutableAttributedString(string: multiplierText)
            multiplierString.addAttributes([NSAttributedString.Key.foregroundColor: textColor,
                                            NSAttributedString.Key.font: textFont],
                                           range: multiplierRange)
            multiplierLabel.attributedText = multiplierString
            ball.physicsBody?.velocity.dy += -500
            targetUBlocker.texture = targetUBlockerTextures[1]
            ball.physicsBody?.collisionBitMask = ball.physicsBody!.collisionBitMask | targetUBlockerCategory
            ball.physicsBody?.contactTestBitMask = ball.physicsBody!.contactTestBitMask | targetUBlockerCategory
            targetUBlocker.run(SKAction.wait(forDuration: 1), completion: { [self] in
                targetUBlocker.texture = targetUBlockerTextures[0]
                ball.physicsBody?.collisionBitMask = ball.physicsBody!.collisionBitMask & ~targetUBlockerCategory
                ball.physicsBody?.contactTestBitMask = ball.physicsBody!.contactTestBitMask & ~targetUBlockerCategory
            })
            if !(ballCounter > maxBalls) {
                let newBall = Ball(position: CGPoint(x: tunnelL.position.x+10, y: tunnelL.position.y), friction: ballFriction, restitution: ballRestitution, categoryBitMask: ballCategory, collisionBitMask: ballCategory | wallCategory | plungerCategory | targetCategory | slingshotCategory | bumperCategory | flipperCategory | removeBallCategory | rampInBlockerCategory, contactTestBitMask: tunnelLCategory | tunnelUCategory | launcherCategory | lockPlungerCategory)
                newBall.name = "Ball" + String(ballCounter)
                ballCounter += 1
                addChild(newBall)
//                balls.updateValue(newBall, forKey: ball.name!)
                newBall.physicsBody?.velocity.dx += 1500
                newBall.run(SKAction.unhide())
                tunnelArrow.run(SKAction.repeat(SKAction.animate(with: tunnelArrowTextures.reversed(), timePerFrame: 0.25), count: 4))
            }
        case "TunnelL":
//            updateScore(objectScore: tunnelScore, multiplier: multiplier)
            break
        case "TunnelU":
            if !muteSounds {
                tunnelSound.run(SKAction.play())
            }
            updateScore(objectScore: tunnelScore, multiplier: multiplier)
            ball.physicsBody?.isDynamic = false
            ball.run(SKAction.hide())
            tunnelArrow.run(SKAction.repeat(SKAction.animate(with: tunnelArrowTextures.reversed(), timePerFrame: 0.5), count: 2))
            self.run(SKAction.wait(forDuration: 1.5), completion: {
                ball.position = CGPoint(x: self.tunnelL.position.x+10, y: self.tunnelL.position.y)
                ball.physicsBody?.isDynamic = true
                ball.physicsBody?.velocity = CGVector(dx: 1500, dy: 0)
                ball.run(SKAction.unhide())
            })
        case "Launcher":
            if !isBeingLaunched {
                isBeingLaunched = true
                if !muteSounds {
                    launcherSound.run(SKAction.play())
                }
                updateScore(objectScore: launcherScore, multiplier: multiplier)
                ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                ball.physicsBody?.isDynamic = false
                ball.position = CGPoint(x: -225, y: 50)
                ball.run(SKAction.wait(forDuration: 1.5), completion: {
                    ball.physicsBody?.isDynamic = true
                    ball.physicsBody?.velocity = CGVector(dx: 1250, dy: 1250)
                })
                launcher.run(SKAction.wait(forDuration: 2), completion: {
                    self.isBeingLaunched = false
                })
            }
        case "lockPlunger":
            plungerLocked = true
            plunger!.releasePlunger()
            plungerChargeSound.run(SKAction.stop())
            if plunger!.tempY == -2 {
                object.run(plungerReleaseSound)
            }
        case "Remove":
//            balls.removeValue(forKey: ball.name!)
            if !muteSounds {
                object.run(ballDrainSound[Int.random(in: 0..<ballDrainSound.count)])
            }
            ball.removeFromParent()
            ballCounter -= 1
            if ballCounter < 1 {
                self.plungerLocked = false
                self.ballInGame = false
                playerLifes -= 1
                if playerLifes == 2 {
                    self.run(SKAction.wait(forDuration: 1.5), completion: { [self] in
                        rampInBlocker.texture = rampInBlockerTextures[0]
                        let newBall = Ball(position: CGPoint(x: 335, y: -150), friction: ballFriction, restitution: ballRestitution, categoryBitMask: ballCategory, collisionBitMask: ballCategory | wallCategory | plungerCategory | targetCategory | slingshotCategory | bumperCategory | flipperCategory | removeBallCategory, contactTestBitMask: tunnelLCategory | tunnelUCategory | launcherCategory | lockPlungerCategory | rampInBlockerCategory)
                        newBall.name = "Ball" + String(ballCounter)
                        ballCounter += 1
                        if !muteSounds {
                            run(newBallSound)
                        }
                        addChild(newBall)
    //                    balls.updateValue(newBall, forKey: newBall.name!)
                        ballLifes[1].texture = ballTextures[1]
                    })
                } else if playerLifes == 1 {
                    self.run(SKAction.wait(forDuration: 1.5), completion: { [self] in
                        rampInBlocker.texture = rampInBlockerTextures[0]
                        let newBall = Ball(position: CGPoint(x: 335, y: -150), friction: ballFriction, restitution: ballRestitution, categoryBitMask: ballCategory, collisionBitMask: ballCategory | wallCategory | plungerCategory | targetCategory | slingshotCategory | bumperCategory | flipperCategory | removeBallCategory, contactTestBitMask: tunnelLCategory | tunnelUCategory | launcherCategory | lockPlungerCategory | rampInBlockerCategory)
                        newBall.name = "Ball" + String(ballCounter)
                        ballCounter += 1
                        if !muteSounds {
                            run(newBallSound)
                        }
                        addChild(newBall)
    //                    balls.updateValue(newBall, forKey: newBall.name!)
                        ballLifes[0].texture = ballTextures[1]
                    })
                } else if playerLifes == 0 {
                    self.run(SKAction.wait(forDuration: 1), completion: { [self] in
                        gameMusic.run(SKAction.changeVolume(to: 0.125, duration: 0.5))
                        run(SKAction.wait(forDuration: 0.5), completion: { [self] in
                            rampInBlocker.texture = rampInBlockerTextures[0]
                            gameOver()
                        })
                    })
                }
            }
        case "Blocker":
            if !ballInGame {
                rampInBlocker.run(SKAction.wait(forDuration: 0.5), completion: { [self] in
                    ball.physicsBody?.collisionBitMask = ball.physicsBody!.collisionBitMask | rampInBlockerCategory
                    rampInBlocker.texture = rampInBlockerTextures[1]
                    ballInGame = true
                })
            } else if !muteSounds {
                object.run(wallHitSound[Int.random(in: 0..<wallHitSound.count)])
            }
        case "Obstacle":
            if !muteSounds {
                object.run(wallHitSound[Int.random(in: 0..<wallHitSound.count)])
            }
        case "Structure":
            if !muteSounds {
                object.run(wallHitSound[Int.random(in: 0..<wallHitSound.count)])
            }
        case "RampIn":
            if !muteSounds {
                object.run(wallHitSound[Int.random(in: 0..<wallHitSound.count)])
            }
        case "SlingshotBody":
            if !muteSounds {
                object.run(rubberHitSound[Int.random(in: 0..<rubberHitSound.count)])
            }
        case "Ball":
            if !muteSounds {
                object.run(ballHitSound[Int.random(in: 0..<ballHitSound.count)])
            }
        case "FlipperL":
            if !muteSounds {
                object.run(rubberHitSound[Int.random(in: 0..<rubberHitSound.count)])
            }
        case "FlipperR":
            if !muteSounds {
                object.run(rubberHitSound[Int.random(in: 0..<rubberHitSound.count)])
            }
        case "Plunger":
            if !muteSounds {
                object.run(rubberHitSound[Int.random(in: 0..<rubberHitSound.count)])
            }
        default:
            break
        }
    }
    
    open func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        if nodeA.name?.contains("Ball") ?? false {
            collision(between: nodeA, object: nodeB)
        } else if nodeB.name?.contains("Ball") ?? false {
            collision(between: nodeB, object: nodeA)
        }
        if (nodeA.name == "FlipperL" && nodeB.name == "Lock") || (nodeB.name == "FlipperL" && nodeA.name == "Lock") {
            flipperLeft?.lockFlipperUp()
        } else if (nodeA.name == "FlipperR" && nodeB.name == "Lock") || (nodeB.name == "FlipperR" && nodeA.name == "Lock") {
            flipperRight?.lockFlipperUp()
        }
        if (nodeA.name == "Plunger" && nodeB.name == "RampIn" && plunger!.isMoving) || (nodeB.name == "Plunger" && nodeA.name == "RampIn" && plunger!.isMoving) {
            plunger?.stopPlunger()
        }
    }
    
    open override func update(_ currentTime: TimeInterval) {
        if plunger!.dY >= -50 {
            plunger!.run(SKAction.move(by: CGVector(dx: 0, dy: plunger!.tempY), duration: 0.1))
            plunger!.dY += plunger!.tempY
        }
    }
    
    open func stopSounds() {
        for child in self.children {
            if child.name == "Sounds" {
                child.run(SKAction.stop())
            }
        }
    }
    
    open func startGame() {
        if firstPlay {
            gameMusic.run(SKAction.play())
            firstPlay = false
        }
        foregroundMenu.removeFromParent()
        startLabel.removeFromParent()
        startButton.removeFromParent()
        gameOverLabel.removeFromParent()
        newScoreLabel.removeFromParent()
        newHighscoreLabel.removeFromParent()
        scoreLabel.removeFromParent()
        gameOverScoreLabel.removeFromParent()
        highscoreLabel.removeFromParent()
        gameOverHighscoreLabel.removeFromParent()
        scoreBackground.removeFromParent()
        gameOverHighscoreLabel.removeFromParent()
        restartLabel.removeFromParent()
        restartButton.removeFromParent()
        playerScore = 0
        multiplier = initMultiplier
        updateScore(objectScore: 0, multiplier: multiplier)
        multiplierText = String(multiplier)
        multiplierRange = NSRange(location: 0, length: multiplierText.count)
        multiplierString = NSMutableAttributedString(string: multiplierText)
        multiplierString.addAttributes([NSAttributedString.Key.foregroundColor: textColor,
                                        NSAttributedString.Key.font: textFont],
                                       range: multiplierRange)
        multiplierLabel.attributedText = multiplierString
        newHighscore = false
        playerLifes = 3
        for i in 0..<playerLifes {
            ballLifes[i].texture = ballTextures[0]
        }
        ball = Ball(position: CGPoint(x: 335, y: -150), friction: ballFriction, restitution: ballRestitution, categoryBitMask: ballCategory, collisionBitMask: ballCategory | wallCategory | plungerCategory | targetCategory | slingshotCategory | bumperCategory | flipperCategory | removeBallCategory, contactTestBitMask: tunnelLCategory | tunnelUCategory | launcherCategory | lockPlungerCategory | rampInBlockerCategory)
        ball.name = "Ball" + String(ballCounter)
        ballCounter += 1
        gameStarted = true
        self.run(SKAction.wait(forDuration: 1.5), completion: { [self] in
            if !muteSounds {
                run(newBallSound)
            }
            addChild(ball)
//            balls.updateValue(ball, forKey: ball.name!)
            ballLifes[2].texture = ballTextures[1]
        })
    }
    
    func gameOver() {
        gameStarted = false
        addChild(foregroundMenu)
        
        // GAME OVER
        let gameOverColor = UIColor(red: 0.8, green: 0, blue: 0, alpha: 1)
        let gameOverFont = UIFont.monospacedSystemFont(ofSize: 100, weight: .black)
        var gameOverText = "GAME OVER"
        var gameOverRange = NSRange(location: 0, length: gameOverText.count)
        var gameOverString = NSMutableAttributedString(string: gameOverText)
        gameOverString.addAttributes([NSAttributedString.Key.foregroundColor: gameOverColor,
                                      NSAttributedString.Key.font: gameOverFont],
                                     range: gameOverRange)
        gameOverLabel.attributedText = gameOverString
        gameOverLabel.numberOfLines = 1
        gameOverLabel.horizontalAlignmentMode = .center
        gameOverLabel.verticalAlignmentMode = .top
        gameOverLabel.position = CGPoint(x: 0, y: 250)
        gameOverLabel.zPosition = CGFloat(1 << 12)
        addChild(gameOverLabel)
        
        // Scores
        scoreBackground.lineWidth = 5
        scoreBackground.fillColor = startColor
        scoreBackground.position = CGPoint(x: 0, y: 15)
        scoreBackground.zPosition = CGFloat(1 << 12)
        addChild(scoreBackground)
        
        if newHighscore {
            // Player Score
            let newScoreColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
            let newScoreFont = UIFont.monospacedSystemFont(ofSize: 25, weight: .black)
            var newScoreText = "Amazing! You got a new highscore"
            var newScoreRange = NSRange(location: 0, length: newScoreText.count)
            var newScoreString = NSMutableAttributedString(string: newScoreText)
            newScoreString.addAttributes([NSAttributedString.Key.foregroundColor: newScoreColor,
                                        NSAttributedString.Key.font: newScoreFont],
                                        range: newScoreRange)
            newScoreLabel.attributedText = newScoreString
            newScoreLabel.numberOfLines = 1
            newScoreLabel.horizontalAlignmentMode = .left
            newScoreLabel.verticalAlignmentMode = .bottom
            newScoreLabel.position = CGPoint(x: -250, y: 15)
            newScoreLabel.zPosition = CGFloat(1 << 12)
            scoreBackground.addChild(newScoreLabel)

            // New Player's Highscore
            let newHighscoreColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
            let newHighscoreFont = UIFont.monospacedSystemFont(ofSize: 25, weight: .black)
            var newHighscoreText = "New highscore:"
            var newHighscoreRange = NSRange(location: 0, length: newHighscoreText.count)
            var newHighscoreString = NSMutableAttributedString(string: newHighscoreText)
            newHighscoreString.addAttributes([NSAttributedString.Key.foregroundColor: newHighscoreColor,
                                            NSAttributedString.Key.font: newHighscoreFont],
                                            range: newHighscoreRange)
            newHighscoreLabel.attributedText = newHighscoreString
            newHighscoreLabel.numberOfLines = 1
            newHighscoreLabel.horizontalAlignmentMode = .left
            newHighscoreLabel.verticalAlignmentMode = .top
            newHighscoreLabel.position = CGPoint(x: -250, y: -13)
            newHighscoreLabel.zPosition = CGFloat(1 << 12)
            scoreBackground.addChild(newHighscoreLabel)

            let gameOverHighscoreColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
            let gameOverHighscoreFont = UIFont.monospacedSystemFont(ofSize: 25, weight: .black)
            var gameOverHighscoreText = String(playerHighscore)
            var gameOverHighscoreRange = NSRange(location: 0, length: gameOverHighscoreText.count)
            var gameOverHighscoreString = NSMutableAttributedString(string: gameOverHighscoreText)
            gameOverHighscoreString.addAttributes([NSAttributedString.Key.foregroundColor: gameOverHighscoreColor,
                                                   NSAttributedString.Key.font: gameOverHighscoreFont],
                                                  range: gameOverHighscoreRange)
            gameOverHighscoreLabel.attributedText = gameOverHighscoreString
            gameOverHighscoreLabel.numberOfLines = 1
            gameOverHighscoreLabel.horizontalAlignmentMode = .right
            gameOverHighscoreLabel.verticalAlignmentMode = .top
            gameOverHighscoreLabel.position = CGPoint(x: 250, y: -13)
            gameOverHighscoreLabel.zPosition = CGFloat(1 << 12)
            scoreBackground.addChild(gameOverHighscoreLabel)
        } else {
            // Player Score
            let scoreColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
            let scoreFont = UIFont.monospacedSystemFont(ofSize: 25, weight: .black)
            var scoreText = "Your score:"
            var scoreRange = NSRange(location: 0, length: scoreText.count)
            var scoreString = NSMutableAttributedString(string: scoreText)
            scoreString.addAttributes([NSAttributedString.Key.foregroundColor: scoreColor,
                                       NSAttributedString.Key.font: scoreFont],
                                      range: scoreRange)
            scoreLabel.attributedText = scoreString
            scoreLabel.numberOfLines = 1
            scoreLabel.horizontalAlignmentMode = .left
            scoreLabel.verticalAlignmentMode = .bottom
            scoreLabel.position = CGPoint(x: -250, y: 15)
            scoreLabel.zPosition = CGFloat(1 << 12)
            scoreBackground.addChild(scoreLabel)

            let gameOverScoreColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
            let gameOverScoreFont = UIFont.monospacedSystemFont(ofSize: 25, weight: .black)
            var gameOverScoreText = String(playerScore)
            var gameOverScoreRange = NSRange(location: 0, length: gameOverScoreText.count)
            var gameOverScoreString = NSMutableAttributedString(string: gameOverScoreText)
            gameOverScoreString.addAttributes([NSAttributedString.Key.foregroundColor: gameOverScoreColor,
                                               NSAttributedString.Key.font: gameOverScoreFont],
                                              range: gameOverScoreRange)
            gameOverScoreLabel.attributedText = gameOverScoreString
            gameOverScoreLabel.numberOfLines = 1
            gameOverScoreLabel.horizontalAlignmentMode = .right
            gameOverScoreLabel.verticalAlignmentMode = .bottom
            gameOverScoreLabel.position = CGPoint(x: 250, y: 15)
            gameOverScoreLabel.zPosition = CGFloat(1 << 12)
            scoreBackground.addChild(gameOverScoreLabel)

            // Player Highscore
            let highscoreColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
            let highscoreFont = UIFont.monospacedSystemFont(ofSize: 25, weight: .black)
            var highscoreText = "Highscore:"
            var highscoreRange = NSRange(location: 0, length: highscoreText.count)
            var highscoreString = NSMutableAttributedString(string: highscoreText)
            highscoreString.addAttributes([NSAttributedString.Key.foregroundColor: highscoreColor,
                                           NSAttributedString.Key.font: highscoreFont],
                                          range: highscoreRange)
            highscoreLabel.attributedText = highscoreString
            highscoreLabel.numberOfLines = 1
            highscoreLabel.horizontalAlignmentMode = .left
            highscoreLabel.verticalAlignmentMode = .top
            highscoreLabel.position = CGPoint(x: -250, y: -13)
            highscoreLabel.zPosition = CGFloat(1 << 12)
            scoreBackground.addChild(highscoreLabel)

            let gameOverHighscoreColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
            let gameOverHighscoreFont = UIFont.monospacedSystemFont(ofSize: 25, weight: .black)
            var gameOverHighscoreText = String(playerHighscore)
            var gameOverHighscoreRange = NSRange(location: 0, length: gameOverHighscoreText.count)
            var gameOverHighscoreString = NSMutableAttributedString(string: gameOverHighscoreText)
            gameOverHighscoreString.addAttributes([NSAttributedString.Key.foregroundColor: gameOverHighscoreColor,
                                                   NSAttributedString.Key.font: gameOverHighscoreFont],
                                                  range: gameOverHighscoreRange)
            gameOverHighscoreLabel.attributedText = gameOverHighscoreString
            gameOverHighscoreLabel.numberOfLines = 1
            gameOverHighscoreLabel.horizontalAlignmentMode = .right
            gameOverHighscoreLabel.verticalAlignmentMode = .top
            gameOverHighscoreLabel.position = CGPoint(x: 250, y: -13)
            gameOverHighscoreLabel.zPosition = CGFloat(1 << 12)
            scoreBackground.addChild(gameOverHighscoreLabel)
        }
        
        // RESTART
        restartButton.name = "Start"
        restartButton.fillColor = buttonColor
        restartButton.position = CGPoint(x: 0, y: -200)
        restartButton.zPosition = CGFloat(1 << 12)
        addChild(restartButton)
        let restartFont = UIFont.monospacedSystemFont(ofSize: 75, weight: .bold)
        var restartText = "PLAY AGAIN"
        var restartRange = NSRange(location: 0, length: restartText.count)
        var restartString = NSMutableAttributedString(string: restartText)
        restartString.addAttributes([NSAttributedString.Key.foregroundColor: startColor,
                                      NSAttributedString.Key.font: restartFont],
                                     range: restartRange)
        restartLabel.attributedText = restartString
        restartLabel.numberOfLines = 1
        restartLabel.horizontalAlignmentMode = .center
        restartLabel.verticalAlignmentMode = .center
        restartLabel.position = CGPoint(x: 0, y: 0)
        restartLabel.zPosition = CGFloat(1 << 12)
        restartButton.addChild(restartLabel)
        
        if !muteSounds {
            gameOverSound.run(SKAction.play())
        }
        self.run(SKAction.wait(forDuration: 2), completion: { [self] in
            gameMusic.run(SKAction.changeVolume(to: 1, duration: 1))
        })
    }
    
    open func switchMusic() {
        if muteMusic {
            if !firstPlay {
                gameMusic.run(SKAction.changeVolume(to: 1, duration: 0))
            }
            muteMusicButton.texture = muteMusicButtonTextures[0]
        } else {
            gameMusic.run(SKAction.changeVolume(to: 0, duration: 0))
            muteMusicButton.texture = muteMusicButtonTextures[1]
        }
        muteMusic = !muteMusic
    }
}
