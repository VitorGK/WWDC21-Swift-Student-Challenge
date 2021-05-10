import UIKit
import SpriteKit

open class PinballViewController: UIViewController {
    
    // Scenes
    let pinballScene: PinballScene = PinballScene()
    
    open override func viewDidLoad() {
        let view = SKView()
        pinballScene.scaleMode = .resizeFill
        pinballScene.size = view.bounds.size
        view.presentScene(pinballScene)
//        view.showsPhysics = true
        self.view = view
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if pinballScene.gameStarted {
            if let touch = touches.first {
                let location = touch.location(in: pinballScene)
                let touchedNodes = pinballScene.nodes(at: location)
                for node in touchedNodes {
                    switch node.name {
                    case "FlipperL":
                        pinballScene.flipperLeft!.raise()
                        if !pinballScene.muteSounds {
                            pinballScene.run(pinballScene.flipperOpenSound)
                        }
                    case "FlipperR":
                        pinballScene.flipperRight!.raise()
                        if !pinballScene.muteSounds {
                            pinballScene.run(pinballScene.flipperOpenSound)
                        }
                    case "PlungerActivator":
                        if !pinballScene.plungerLocked {
                            pinballScene.plunger?.chargePlunger()
                            if !pinballScene.muteSounds {
                                pinballScene.plungerChargeSound.run(SKAction.play())
                            }
                        }
                    default:
                        break
                    }
                }
            }
        }
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: pinballScene)
            let touchedNodes = pinballScene.nodes(at: location)
            for node in touchedNodes {
                switch node.name {
                case "FlipperL":
                    if pinballScene.gameStarted {
                        pinballScene.flipperLeft!.lower()
                        if !pinballScene.muteSounds {
                            pinballScene.run(pinballScene.flipperCloseSound)
                        }
                    }
                case "FlipperR":
                    if pinballScene.gameStarted {
                        pinballScene.flipperRight!.lower()
                        if !pinballScene.muteSounds {
                            pinballScene.run(pinballScene.flipperCloseSound)
                        }
                    }
                case "PlungerActivator":
                    if pinballScene.gameStarted {
                        if !pinballScene.plungerLocked {
                            pinballScene.plunger?.releasePlunger()
                            if !pinballScene.muteSounds {
                                pinballScene.plungerChargeSound.run(SKAction.stop())
                                pinballScene.run(pinballScene.plungerReleaseSound)
                            }
                        }
                    }
                case "MuteSoundsButton":
                    pinballScene.muteSounds = !pinballScene.muteSounds
                    pinballScene.stopSounds()
                    pinballScene.muteSoundsButton.texture = pinballScene.muteSoundsButtonTextures[pinballScene.muteSounds == true ? 1 : 0]
                case "MuteMusicButton":
                    pinballScene.switchMusic()
                case "Start":
                    if !pinballScene.gameStarted {
                        if !pinballScene.muteSounds {
                            pinballScene.run(pinballScene.coinInSound)
                        }
                        pinballScene.startGame()
                    }
                default:
                    break
                }
            }
        }
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if pinballScene.gameStarted {
            if let touch = touches.first {
                let location = touch.location(in: pinballScene)
                let touchedNodes = pinballScene.nodes(at: location)
                for node in touchedNodes {
                    switch node.name {
                    case "FlipperL":
                        pinballScene.flipperLeft!.lower()
                        if !pinballScene.muteSounds {
                            pinballScene.run(pinballScene.flipperCloseSound)
                        }
                    case "FlipperR":
                        pinballScene.flipperRight!.lower()
                        if !pinballScene.muteSounds {
                            pinballScene.run(pinballScene.flipperCloseSound)
                        }
                    case "PlungerActivator":
                        if !pinballScene.plungerLocked {
                            pinballScene.plunger?.releasePlunger()
                            if !pinballScene.muteSounds {
                                pinballScene.plungerChargeSound.run(SKAction.stop())
                                pinballScene.run(pinballScene.plungerReleaseSound)
                            }
                        }
                    default:
                        break
                    }
                }
            }
        }
    }
}
