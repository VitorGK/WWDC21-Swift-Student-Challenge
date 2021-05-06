import UIKit
import SpriteKit

open class PinballViewController: UIViewController {
    let scene = PinballScene()
    
    open override func viewDidLoad() {
        let view = SKView()
        scene.scaleMode = .resizeFill
        scene.size = view.bounds.size
        view.presentScene(scene)
//        view.showsPhysics = true
        self.view = view
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: scene)
            let touchedNodes = scene.nodes(at: location)
            for node in touchedNodes {
                if node.name == "FlipperL" {
                    scene.flipperLeft!.raise()
                } else if node.name == "FlipperR" {
                    scene.flipperRight!.raise()
                } else if node.name == "Plunger" && !scene.plungerLocked {
                    scene.plunger?.chargePlunger()
                }
            }
        }
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: scene)
            let touchedNodes = scene.nodes(at: location)
            for node in touchedNodes {
                if node.name == "FlipperL" {
                    scene.flipperLeft!.lower()
                } else if node.name == "FlipperR" {
                    scene.flipperRight!.lower()
                } else if node.name == "Plunger" && !scene.plungerLocked {
                    scene.plunger?.releasePlunger()
                }
            }
        }
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: scene)
            let touchedNodes = scene.nodes(at: location)
            for node in touchedNodes {
                if node.name == "FlipperL" {
                    scene.flipperLeft!.lower()
                } else if node.name == "FlipperR" {
                    scene.flipperRight!.lower()
                } else if node.name == "Plunger" && !scene.plungerLocked {
                    scene.plunger?.releasePlunger()
                }
            }
        }
    }
}
