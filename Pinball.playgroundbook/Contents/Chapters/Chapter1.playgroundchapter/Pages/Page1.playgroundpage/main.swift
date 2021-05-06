/*:
 # Hello there!
 
 My name is Vitor and in this Playground, I'm going to show you a few things about **pinball**:
 
 - The basic idea of a pinball game;
 - How a few parts of a pinball machine works; and
 - A **playable pinball machine** for you to play, score points and have fun!
 ___
 
 *First things first, so...*
 ## Do you know what is pinball?
 
 Pinball is an arcade game in which a player can control flippers to hit balls (usually metal balls) and score points.
 
 The main goal is to score as many points as possible, keeping the ball in the playfield and not letting it be "drained" at the bottom.
 ___
 
 ## The playfield
 
 The pinball playfield is a surface that contains a lot of hittable objects, such as targets, bumpers, slingshots, ramps and many others that vary according to the pinball machine you are playing.
 ___
 
 ## Images
 Feel free to edit and run the code below to see a few images of pinball machines.
 ___
 
 *In the next page, we will see a few objects and how they work.*
*/
//#-code-completion(everything, hide)
//#-code-completion(currentmodule, show, image1, image2, image3)

let liveViewImage: Image = ./*#-editable-code Type here*/image1/*#-end-editable-code*/

//#-hidden-code
enum Image: String {
    case image1 = "Image1.jpg"
    case image2 = "Image2.jpg"
    case image3 = "Image3.jpg"
}

import UIKit

open class IntroViewController: UIViewController {
    open override func viewDidLoad() {
        let view = UIView()
        let image = UIImageView(image: UIImage(named: liveViewImage.rawValue))
        view.backgroundColor = .black
        view.addSubview(image)
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        image.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        image.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.view = view
    }
}

import PlaygroundSupport

PlaygroundPage.current.setLiveView(IntroViewController())
//#-end-hidden-code
/*:
 **Use each of these in the text box to see the images:**
 - image1
 - image2
 - image3
 ___
 
 *Image references from Unsplash*
 - *Image1 from @sickhews*
 - *Image2 from @julianlozano*
 - *Image3 from @sigmund*
 */
