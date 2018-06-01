//
//  LiveView.swift
//
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import SpriteKit
import PlaygroundSupport

class LabelController: UIViewController {
	override public func viewDidLoad() {
		super.viewDidLoad()
		
		self.view.backgroundColor = .black
		let viewFrame = self.view.frame
		
		let label = UILabel(frame: CGRect(x: 50, y: 0, width: viewFrame.width/2 - 50, height: viewFrame.height))
		label.textAlignment = .left
		label.text = "Choose the difficulty of your mission, put the Live View in full screen and tap 'Run My Code'."
		label.numberOfLines = 0
		label.font = UIFont.boldSystemFont(ofSize: 25)
		label.textColor = .white
		
		self.view.addSubview(label)
	}
}

let page = PlaygroundPage.current
page.needsIndefiniteExecution = true
page.liveView = LabelController()
