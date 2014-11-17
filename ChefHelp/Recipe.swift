//
//  Recipe.swift
//  Chefhelp_prototype1
//
//  Created by Benjamin San Soucie on 10/19/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

import Foundation

struct Recipe {
	let name: String
	let ingredients: [GroupProtocol] // ingredients list can contain groups or ingredients
	let steps: [GroupProtocol]
	let difficulty: Difficulty
	let totalTime: Int
	
	init(name: String, ingredients: [GroupProtocol], steps: [GroupProtocol], difficulty: Difficulty) {
		self.name = name
		self.ingredients = ingredients
		self.steps = steps
		self.difficulty = difficulty
		self.totalTime = computeTotalTime(steps)
	}
}

func ==(lhs: Recipe, rhs: Recipe) -> Bool {
	return lhs.name == rhs.name
}

func computeTotalTime(steps: [GroupProtocol]) -> Int {
	var total: Int = 0
	for step in steps {
		if let g = step as? Group {
			total += computeTotalTime(g.rest)
		} else if let s = step as? Step  {
			total += s.time
		}
	}
	
	return total
}

enum Difficulty: String {
	case Easy = "easy"
	case Moderate = "moderate"
	case Hardcore = "hard"
}