//
//  EndViewController.swift
//  WWDC18
//
//  Created by Lucas Ferraço on 23/03/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import UIKit

public class EndViewController: UIViewController {
	
	private var teamImageViews: [UIImageView]! = []
	private var attStrings: [String]! = []
	
	// Good stuff
	private var empathic: Int = 0
	private var groupWork: Int = 0
	private var socialRelationship: Int = 0
	private var kindness: Int = 0
	private var creative: Int = 0
	
	// Bad stuff
	private var manipulator: Int = 0
	private var greedy: Int = 0
	private var powerAddicted: Int = 0
	private var criminal: Int = 0
	
	override public func loadView() {
		self.view = UIView(frame: UIScreen.main.bounds)
	}
	
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
		
		let selectedTeam = KeyValueStore.sharedInstance.fetchCharacters()
		let selectedPersonsImages = selectedTeam.map { (person) -> UIImage in
			return person.image
		}
		
		selectedTeam.forEach { (person) in
			empathic += person.attributes.empathic
			groupWork += person.attributes.groupWork
			socialRelationship += person.attributes.socialRelationship
			kindness += person.attributes.kindness
			creative += person.attributes.creative
			manipulator += person.attributes.manipulator
			greedy += person.attributes.greedy
			powerAddicted += person.attributes.powerAddicted
			criminal += person.attributes.criminal
		}
		
		attStrings.append("Attributes:")
		attStrings.append("empathic = \(empathic)")
		attStrings.append("group work = \(groupWork)")
		attStrings.append("social relationship = \(socialRelationship)")
		attStrings.append("kindness = \(kindness)")
		attStrings.append("creative = \(creative)")
		attStrings.append("manipulator = \(manipulator)")
		attStrings.append("greedy = \(greedy)")
		attStrings.append("power addicted = \(powerAddicted)")
		attStrings.append("criminal = \(criminal)")
		
		self.setupViews(with: selectedPersonsImages)
    }
	
	private func setupViews(with images: [UIImage]) {
		self.teamImageViews = []
		
		let slotsWidth: CGFloat = self.view.frame.width/6
		let slotsHeight: CGFloat = slotsWidth * 7/6
		let xPadding: CGFloat = 15
		var slotsX: CGFloat = 30
		var slotsY: CGFloat = 30
		
		for i in 0..<images.count {
			let imageView = UIImageView(frame: CGRect(x: slotsX, y: slotsY, width: slotsWidth, height: slotsHeight))
			imageView.image = images[i]
			imageView.contentMode = .scaleAspectFit
			
			self.teamImageViews.append(imageView)
			self.view.addSubview(imageView)
			
			slotsX += slotsWidth + xPadding
			
			if (slotsX + slotsWidth) >= self.view.frame.width/2 {
				if i == 4 {
					slotsX = slotsWidth/2 + xPadding
				} else {
					slotsX = 30
				}
				
				slotsY += slotsHeight + 20
			}
		}
		
		for text in attStrings {
			let label = UILabel(frame: CGRect(x: slotsX, y: slotsY, width: slotsWidth, height: 20))
			label.font = UIFont.boldSystemFont(ofSize: 20)
			label.textColor = .white
			label.textAlignment = .left
			
			label.text = text
			self.view.addSubview(label)
			
			slotsY += 25
		}
	}
}
