//
//  GetPersonsModes.swift
//  WWDC18
//
//  Created by Lucas Ferraço on 28/03/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import UIKit

public enum GameMode {
	case easy, medium, hard
}

public class GetPersonsManager {
	public let mode: GameMode!
	
	public let totalQuestTime: Int!
	public let momentPerPerson: [Int : Person]!
	
	public init(mode: GameMode) {
		self.mode = mode
		
		switch mode {
		case .easy:
			self.totalQuestTime = 90
			self.momentPerPerson = [
				2 	: Personas.Queen,
				12	: Personas.Mobster,
				18	: Personas.Astronaut,
				20 	: Personas.Executive,
				24	: Personas.Scientist,
				27	: Personas.Burglar,
				34	: Personas.Feminist,
				37	: Personas.Inventor,
				46	: Personas.Dictator,
				53	: Personas.Athlete,
				64	: Personas.Innocent,
				77	: Personas.Singer,
				82	: Personas.Pacifist,
			]
			
		case .medium:
			self.totalQuestTime = 60
			self.momentPerPerson = [
				3	: Personas.Inventor,
				4 	: Personas.Executive,
				9	: Personas.Singer,
				10	: Personas.Scientist,
				16 	: Personas.Queen,
				19	: Personas.Burglar,
				21	: Personas.Innocent,
				27	: Personas.Athlete,
				29	: Personas.Dictator,
				32	: Personas.Pacifist,
				38	: Personas.Mobster,
				43	: Personas.Feminist,
				55	: Personas.Astronaut
			]
			
		case .hard:
			self.totalQuestTime = 30
			self.momentPerPerson = [
				2	: Personas.Feminist,
				4	: Personas.Inventor,
				7 	: Personas.Executive,
				8	: Personas.Scientist,
				10 	: Personas.Queen,
				11	: Personas.Dictator,
				14	: Personas.Astronaut,
				15	: Personas.Burglar,
				18	: Personas.Innocent,
				19	: Personas.Singer,
				20	: Personas.Mobster,
				23	: Personas.Athlete,
				24	: Personas.Pacifist
			]
			
		}
	}
	
	public func personToSpawn(at time: Int) -> Person? {
		if let personToSpawn = self.momentPerPerson[time] {
			return personToSpawn
		}
		
		return nil
	}
}
