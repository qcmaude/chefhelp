//
//  Ingredient.swift
//  Chefhelp_prototype1
//
//  Created by Benjamin San Soucie on 10/19/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

import Foundation

class Ingredient: GroupProtocol {
	let name: String
	let attributes: String
	let importance: Importance
	let quantity: Float
	let unit: Unit
	
	init(name: String, attributes: String, importance: Importance, quantity: Float, unit: Unit) {
		self.name = name
		self.attributes = attributes
		self.importance = importance
		self.quantity = quantity
		self.unit = unit
	}
}

enum Importance: String {
	case MainIngredient = "main ingredient"
	case SecondaryIngredient = "secondary ingredient"
//	case OptionalIngredient = "optional ingredient"
}

enum Unit: String {
	case Cup = "cup"
	case TableSpoon = "table spoon"
	case TeaSpoon = "tea spoon"
	case Gram = "gram"
	case Whole = ""
}