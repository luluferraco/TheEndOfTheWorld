//
//  SlotView.swift
//  WWDC18
//
//  Created by Lucas Ferraço on 25/03/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import UIKit

public protocol SlotViewProtocol {
	func willRemove(person: Person, at index: Int)
}

public class SlotView: UIView, UIGestureRecognizerDelegate {
	private var delegate: SlotViewProtocol!
	
	private var imageView: UIImageView!
	private var deleteButton: UIButton!
	private let defaultImage = UIImage(named: "EmptySlot")
	
	private var person: Person? = nil
	
	public init(frame: CGRect, delegate: SlotViewProtocol) {
		super.init(frame: frame)
		
		self.delegate = delegate
		self.backgroundColor = .clear
		
		self.imageView = UIImageView(frame: CGRect(origin: CGPoint.zero, size: frame.size))
		self.imageView.contentMode = .scaleAspectFit
		self.imageView.image = defaultImage
		self.imageView.layer.borderColor = UIColor.black.cgColor
		self.imageView.layer.backgroundColor = UIColor.white.cgColor
		self.imageView.layer.borderWidth = 2
		self.imageView.layer.cornerRadius = 5
		
		let btnDimension: CGFloat = 15
		self.deleteButton = UIButton(frame: CGRect(x: self.imageView.frame.maxX - btnDimension/2,
												   y: self.imageView.frame.minY - btnDimension/2,
												   width: btnDimension, height: btnDimension))
		self.deleteButton.setImage(#imageLiteral(resourceName: "delete"), for: .normal)
		self.deleteButton.addTarget(self, action: #selector(self.changeImage), for: .touchUpInside)
		self.deleteButton.isHidden = true
		
		self.addSubview(self.imageView)
		self.addSubview(self.deleteButton)
	}
	
	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override public func willMove(toSuperview newSuperview: UIView?) {
		super.willMove(toSuperview: newSuperview)
		
		let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.changeImage))
		tapRecognizer.delegate = self
		
		self.isUserInteractionEnabled = true
		self.addGestureRecognizer(tapRecognizer)
	}
	
	public func setCharacterImageWith(person: Person?) {
		self.person = person
		
		if let p = person {
			self.imageView.image = p.image
			self.deleteButton.isHidden = false
		} else {
			self.imageView.image = defaultImage
			self.deleteButton.isHidden = true
		}
	}
	
	@objc private func changeImage() {
		if let image = self.imageView.image, image != defaultImage {
			self.delegate?.willRemove(person: self.person!, at: self.tag)
			
			self.person = nil
			self.imageView.image = defaultImage
			self.deleteButton.isHidden = true
		}
	}
	
}
