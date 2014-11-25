//
//  Step.swift
//  Chefhelp_prototype1
//
//  Created by Benjamin San Soucie on 10/19/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

import Foundation

class Step: GroupProtocol {
	let name: String
	let ingredientsNeeded: [GroupProtocol]
	let time: Int
	let explanation: String
	let timers: [Int]
	let color1: UIColor
	let color2: UIColor
	
	init(name: String, ingredientsNeeded: [GroupProtocol], time: Int, explanation: String, timers: [Int], color1: UIColor, color2: UIColor) {
		self.name = name
		self.ingredientsNeeded = ingredientsNeeded
		self.time = time
		self.explanation = explanation
		self.timers = timers
		self.color1 = color1
		self.color2 = color2
	}
}