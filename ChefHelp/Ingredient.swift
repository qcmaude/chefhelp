//
//  Ingredient.swift
//  Chefhelp_prototype1
//
//  Created by Benjamin San Soucie on 10/19/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

import Foundation

class Ingredient: GroupProtocol {
	let attributes: String
	let importance: Importance
	let quantity: Float
	let unit: Unit
	let name: String
	
	init(name: String, attributes: String, importance: Importance, quantity: Float, unit: Unit) {
		self.unit = unit
		self.name = name
		self.attributes = attributes
		self.importance = importance
		self.quantity = quantity
	}
}

func ==(lhs: Ingredient, rhs: Ingredient) -> Bool {
	return lhs.name == rhs.name
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