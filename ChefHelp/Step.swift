//
//  Step.swift
//  Chefhelp_prototype1
//
//  Created by Benjamin San Soucie on 10/19/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

import Foundation

class Step: GroupProtocol {
	let goal: String
	let ingredientsNeeded: [GroupProtocol]
	let time: Int
	let explanation: String
	let timers: [Int]
	
	init(goal: String, ingredientsNeeded: [GroupProtocol], time: Int, explanation: String, timers: [Int]) {
		self.goal = goal
		self.ingredientsNeeded = ingredientsNeeded
		self.time = time
		self.explanation = explanation
		self.timers = timers
	}
}