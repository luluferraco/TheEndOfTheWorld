//
//  TimerNode.swift
//  WWDC18
//
//  Created by Lucas Ferraço on 30/03/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import UIKit

public class TimerLabel: UILabel {
	
	private let defaultFont = UIFont.boldSystemFont(ofSize: 30)
	
	public init(origin: CGPoint) {
		let size = NSAttributedString(string: "00:00", attributes: [NSAttributedStringKey.font : self.defaultFont]).size()
		let correctedOrigin = CGPoint(x: origin.x - size.width/2,
									  y: origin.y)
		
		super.init(frame: CGRect(origin: correctedOrigin, size: size))
		
		let padding: CGFloat = 10
		self.layer.frame = CGRect(x: self.frame.minX - padding/2,
								  y: self.frame.minY - padding/2,
								  width: self.frame.width + padding,
								  height: self.frame.height + padding)
		self.layer.borderColor = UIColor.black.cgColor
		self.layer.borderWidth = 3
		self.layer.backgroundColor = UIColor.white.cgColor
		self.layer.cornerRadius = 5
		
		self.font = defaultFont
		self.textColor = .black
		self.textAlignment = .center
	}
	
	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
