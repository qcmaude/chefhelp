//
//  Recipe.swift
//  Chefhelp_prototype1
//
//  Created by Benjamin San Soucie on 10/19/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

import Foundation

public struct Recipe {
	let recipeName: String
	let ingredients: [Ingredient]
	let steps: [Step]
	let totalTime: Int
	let difficulty: String
}