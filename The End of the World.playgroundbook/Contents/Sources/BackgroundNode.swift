//
//  BackgroundNode.swift
//  WWDC18
//
//  Created by Lucas Ferraço on 24/03/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import SpriteKit

public class BackgroundNode: SKSpriteNode {
	
	public init(sceneSize: CGSize) {
		let texture = SKTexture(imageNamed: "background")
		super.init(texture: texture, color: .clear, size: texture.size())
		
		self.position = CGPoint(x: sceneSize.width / 2, y: sceneSize.height / 2)
		self.size = CGSize(width: 667 * sceneSize.width / 667, height: 375 * sceneSize.height / 375)
	}
	
	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
