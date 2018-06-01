//
//  StarTextScene.swift
//  WWDC18
//
//  Created by Lucas Ferraço on 24/03/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import SpriteKit

fileprivate let historyText = [
	"In 3018, it's a period of fear and despair.",
	"A thousand years ago, the renowned scientist",
	"Stephen Hawking had already warned about",
	"the end of the world that's happening now…",
	"Humans are attacking everything on their surrounding, destroying nature.",
	"The Nuclear War wiped out millions of lives.",
	"And the remaining people are struggling to find a new home,",
	"because the Earth is becoming inhospitable.",
	"We have up to a year on Earth before it collapses.",
	"       ",
	"A team is preparing to start over on a recently new planet",
	"found to try to save the human race…"
]

public class StarTextScene: SKScene {
	
	// User definable variables
	public var velocityMultiplier: Int = 1
	
	private var lineLabelNodes: [SKLabelNode]! = []
	private let fontSize = 25
	private var textAttributes: [NSAttributedStringKey : Any]! = [
		NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 25),
		NSAttributedStringKey.foregroundColor : UIColor.yellow
	]
	
	override public init(size: CGSize) {
		super.init(size: size)
		
		let background = BackgroundNode(sceneSize: size)
		self.addChild(background)
		
		let backgroundMusic = SKAction.playSoundFileNamed("MedievalTheme.mp3", waitForCompletion: true)
		background.run(SKAction.repeatForever(backgroundMusic))
		
		for i in 0..<historyText.count {
			let lineNode = SKLabelNode(attributedText: NSAttributedString(string: historyText[i], attributes: self.textAttributes))
			lineNode.position = CGPoint(x: size.width/2, y: CGFloat(self.fontSize * 2 * (-i)))
			lineNode.zPosition = 1
			lineNode.alpha = 1
			lineNode.setScale(1.5)
			
			lineLabelNodes.append(lineNode)
		}
		
		for label in self.lineLabelNodes {
			self.addChild(label)
		}
	}
	
	public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public override func update(_ currentTime: TimeInterval) {
		for i in 0..<self.lineLabelNodes.count {
			let label = self.lineLabelNodes[i]
			var actions: [SKAction] = []
			
			if label.position.y > self.size.height {
				label.removeFromParent()
				
				if i == self.lineLabelNodes.count - 1 {
					self.showContinueLabel()
				}
			} else {
				actions.append(SKAction.moveBy(x: 0, y: CGFloat(self.velocityMultiplier), duration: 1))
				
				if label.position.y > 0 {
					actions.append(SKAction.scale(by: 0.99, duration: TimeInterval(170 - self.velocityMultiplier * 5)))
				}
				
				label.run(SKAction.group(actions))
			}
		}
	}
	
	private func showContinueLabel() {
		let continueLabel = SKLabelNode(text: "Continue to your mission, go to the next page!")
		continueLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
		continueLabel.fontSize = 35
		continueLabel.fontName = UIFont.boldSystemFont(ofSize: 30).fontName
		continueLabel.fontColor = .yellow
		
		self.addChild(continueLabel)
	}
}
