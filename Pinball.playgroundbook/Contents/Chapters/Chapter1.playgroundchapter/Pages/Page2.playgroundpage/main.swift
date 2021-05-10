/*:
 # How does it work?
 
 The pinball machines use a lot of mechanical components, mainly [switches](glossary://switch) and [solenoids](glossary://solenoid).
 ___
 
 Most of the individual parts work the same way: an electric circuit is closed, triggering an action, most of the times taken by a solenoid, kicking the ball back, changing its path etc.

 The electric current is established when the ball hits a specific point on the object, making two tiny metal plates touch each other, closing the circuit.
 ___
 
 ## Examples
 
 Press **Run My Code** to open the live view, which will show a little more of what a few individual objects can do in the playfield.
 
 ___
 
 *In the [next page](@next), you will be able to experience an emulation of a simple pinball machine with most of its objects reacting to ball hits.*
 */
//#-code-completion(everything, hide)
//#-hidden-code
import Pinball
import UIKit
import SpriteKit

open class ExamplesViewController: UIViewController {
    let scenes: [SKScene] = [FlippersExampleScene(), SlingshotsExampleScene(), BumpersExampleScene(), TunnelsExampleScene(), PlungerExampleScene(), EndExampleScene()]
    var sceneNumber: Int = 0
    open override func viewDidLoad() {
        let view = SKView()
        for scene in scenes {
            scene.scaleMode = .resizeFill
            scene.size = view.bounds.size
        }
//        view.showsPhysics = true;
        view.presentScene(scenes[sceneNumber])
        self.view = view
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if sceneNumber < 5 {
                sceneNumber += 1
                let view = SKView()
//                view.showsPhysics = true;
                view.presentScene(scenes[sceneNumber])
                self.view = view
            }
        }
    }
}

import PlaygroundSupport

PlaygroundPage.current.setLiveView(ExamplesViewController())
//#-end-hidden-code
