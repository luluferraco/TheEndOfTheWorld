//
//  Personas.swift
//  WWDC18
//
//  Created by Lucas Ferraço on 24/03/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import UIKit

public struct Personas {
	public static let Executive = Person(
		stereotype: "Executive",
		attributes: Attributes(groupWork: 3, socialRelationship: 6, creative: 5, manipulator: 8, greedy: 10, powerAddicted: 10, criminal: 2)
	)
	
	public static let Queen = Person(
		stereotype: "Queen",
		attributes: Attributes(empathic: 8, groupWork: 5, socialRelationship: 10, kindness: 8, greedy: 7, powerAddicted: 8)
	)
	
	public static let Scientist = Person(
		stereotype: "Scientist",
		attributes: Attributes(groupWork: 8, creative: 10, greedy: 7)
	)
	
	public static let Dictator = Person(
		stereotype: "Dictator",
		attributes: Attributes(socialRelationship: 3, manipulator: 10, greedy: 10, powerAddicted: 10, criminal: 10)
	)
	
	public static let Feminist = Person(
		stereotype: "Feminist",
		attributes: Attributes(empathic: 10, groupWork: 8, socialRelationship: 6, kindness: 8, creative: 10, manipulator: 3)
	)
	
	public static let Pacifist = Person(
		stereotype: "Pacifist",
		attributes: Attributes(empathic: 10, groupWork: 8, socialRelationship: 9, kindness: 10)
	)
	
	public static let Innocent = Person(
		stereotype: "Innocent",
		attributes: Attributes(empathic: 8, socialRelationship: 8, kindness: 10, creative: 10, manipulator: 5)
	)
	
	public static let Inventor = Person(
		stereotype: "Inventor",
		attributes: Attributes(empathic: 7, socialRelationship: 6, creative: 10, manipulator: 8, greedy: 10, powerAddicted: 6)
	)
	
	public static let Athlete = Person(
		stereotype: "Athlete",
		attributes: Attributes(groupWork: 10, socialRelationship: 8, creative: 8, greedy: 10)
	)
	
	public static let Burglar = Person(
		stereotype: "Burglar",
		attributes: Attributes(groupWork: 6, socialRelationship: 3, greedy: 10, criminal: 10)
	)
	
	public static let Mobster = Person(
		stereotype: "Mobster",
		attributes: Attributes(groupWork: 9, socialRelationship: 5, manipulator: 8, greedy: 8, criminal: 10)
	)
	
	public static let Singer = Person(
		stereotype: "Singer",
		attributes: Attributes(empathic: 6, groupWork: 8, socialRelationship: 9, kindness: 10)
	)
	
	public static let Astronaut = Person(
		stereotype: "Astronaut",
		attributes: Attributes(groupWork: 9, socialRelationship: 5, creative: 8)
	)
	
	public static func all() -> [Person] {
		return [
			Personas.Executive,
			Personas.Queen,
			Personas.Scientist,
			Personas.Dictator,
			Personas.Feminist,
			Personas.Pacifist,
			Personas.Innocent,
			Personas.Inventor,
			Personas.Athlete,
			Personas.Burglar,
			Personas.Mobster,
			Personas.Singer,
			Personas.Astronaut
		]
	}
}
