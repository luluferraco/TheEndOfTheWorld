//
//  Person.swift
//  WWDC18
//
//  Created by Lucas Ferraço on 24/03/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import UIKit

public struct Attributes {
	// Good stuff
	public var empathic: Int
	public var groupWork: Int
	public var socialRelationship: Int
	public var kindness: Int
	public var creative: Int
	
	// Bad stuff
	public var manipulator: Int
	public var greedy: Int
	public var powerAddicted: Int
	public var criminal: Int
	
	public init(empathic: Int = 0,
		 groupWork: Int = 0,
		 socialRelationship: Int = 0,
		 kindness: Int = 0,
		 creative: Int = 0,
		 manipulator: Int = 0,
		 greedy: Int = 0,
		 powerAddicted: Int = 0,
		 criminal: Int = 0) {
		self.empathic = empathic
		self.groupWork = groupWork
		self.socialRelationship = socialRelationship
		self.kindness = kindness
		self.creative = creative
		self.manipulator = manipulator
		self.greedy = greedy
		self.powerAddicted = powerAddicted
		self.criminal = criminal
	}
}

public class Person {
	public var stereotype: String!
	public var attributes: Attributes!
	public var image: UIImage!
	
	public var closeQuarters = false // Whether it is in the goldilocks zone
	
	init(stereotype: String, attributes: Attributes) {
		self.stereotype = stereotype
		self.attributes = attributes
		self.image = UIImage(named: stereotype.lowercased())
	}
}

extension Person: Equatable {
	public static func ==(lhs: Person, rhs: Person) -> Bool {
		return lhs.image == rhs.image
	}
}
