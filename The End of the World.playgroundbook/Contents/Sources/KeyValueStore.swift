//
//  KeyValueStore.swift
//  WWDC18
//
//  Created by Lucas Ferraço on 24/03/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import Foundation
import PlaygroundSupport

public class KeyValueStore {
	private let charactersKey = "characters"
	
	//MARK: Singleton Definition
	private static var theOnlyInstance: KeyValueStore?
	static var sharedInstance: KeyValueStore {
		get {
			if theOnlyInstance == nil {
				theOnlyInstance = KeyValueStore()
			}
			return theOnlyInstance!
		}
	}
	private init() {}
	
	public func saveCharacters(_ chars: [Person]) {
		let charsStereotypes = chars.map { (person) -> PlaygroundValue in
			return PlaygroundValue.string(person.stereotype)
		}
		
		PlaygroundKeyValueStore.current[charactersKey] = .array(charsStereotypes)
	}
	
	public func fetchCharacters() -> [Person] {
		var fetchedChars: [String] = []
		
		if let keyValue = PlaygroundKeyValueStore.current[charactersKey],
			case .array(let savedChars) = keyValue {
			for char in savedChars {
				if case .string(let stereotype) = char {
					fetchedChars.append(stereotype)
				}
			}
		}
		
		return Personas.all().filter { (person) -> Bool in
			return fetchedChars.contains(person.stereotype)
		}
	}
}
