import SpriteKit

open class EndExampleScene: SKScene {
    
    open override func didMove(to view: SKView) {
        super.didMove(to: view)
        backgroundColor = .darkGray
        
        // Text
        let label = SKLabelNode()
        
        let text: String = "A lot of other objects are used as well, such as targets, spinners, ramps, magnets..."
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let range = NSRange(location: 0, length: text.count)
        
        let attrString = NSMutableAttributedString(string: text)
        attrString.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle,
                                  NSAttributedString.Key.foregroundColor: UIColor.white,
                                  NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)],
                                 range: range)
        label.attributedText = attrString
        label.numberOfLines = -1
        label.preferredMaxLayoutWidth = 500
        label.verticalAlignmentMode = .top
        label.position = CGPoint(x: 0, y: 350)
        addChild(label)
        
        // Text 2
        let label2 = SKLabelNode()
        
        let text2: String = "It depends on the model of the pinball machine and the experience their creator wants us to have."
        let paragraphStyle2 = NSMutableParagraphStyle()
        paragraphStyle2.alignment = .center
        let range2 = NSRange(location: 0, length: text2.count)
        
        let attrString2 = NSMutableAttributedString(string: text2)
        attrString2.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle2,
                                  NSAttributedString.Key.foregroundColor: UIColor.white,
                                  NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)],
                                 range: range2)
        label2.attributedText = attrString2
        label2.numberOfLines = -1
        label2.preferredMaxLayoutWidth = 500
        label2.verticalAlignmentMode = .top
        label2.position = CGPoint(x: 0, y: 153)
        addChild(label2)
        
        // End
        let labelEnd = SKLabelNode()
        
        let textEnd: String = "Now that you know what these few objects do, why don't we test a cool virtual pinball machine?\n\n\nLet's go to the next page!"
        let paragraphStyleEnd = NSMutableParagraphStyle()
        paragraphStyleEnd.alignment = .center
        let rangeEnd = NSRange(location: 0, length: textEnd.count)
        
        let boldText: String = "pinball machine"
        let rangeBold = (textEnd as NSString).range(of: boldText)
        
        let italicText: String = "virtual"
        let rangeItalic = (textEnd as NSString).range(of: italicText)
        
        let rangeColor2 = (textEnd as NSString).range(of: italicText)
        
        let attrStringEnd = NSMutableAttributedString(string: textEnd)
        attrStringEnd.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyleEnd,
                                  NSAttributedString.Key.foregroundColor: UIColor.white,
                                  NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)],
                                 range: rangeEnd)
        attrStringEnd.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 30), range: rangeBold)
        attrStringEnd.addAttribute(NSAttributedString.Key.font, value: UIFont.italicSystemFont(ofSize: 30), range: rangeItalic)
        attrStringEnd.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray, range: rangeColor2)
        labelEnd.attributedText = attrStringEnd
        labelEnd.numberOfLines = -1
        labelEnd.preferredMaxLayoutWidth = 500
        labelEnd.verticalAlignmentMode = .top
        labelEnd.position = CGPoint(x: 0, y: -44)
        addChild(labelEnd)
        
        // Next
        let labelNext = SKLabelNode()
        
        let textNext: String = "To start over, press stop and run the code again"
        let paragraphStyleNext = NSMutableParagraphStyle()
        paragraphStyleNext.alignment = .center
        let rangeNext = NSRange(location: 0, length: textNext.count)
        
        let attrStringNext = NSMutableAttributedString(string: textNext)
        attrStringNext.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyleNext,
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
}

