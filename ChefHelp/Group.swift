//
//  Group.swift
//  Chefhelp_prototype1
//
//  Created by Benjamin San Soucie on 10/19/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

import Foundation

class Group: GroupProtocol {
	let name: String
	let rest: [GroupProtocol]
	
	init(name: String, rest: [GroupProtocol]) {
		self.name = name
		self.rest = rest
	}
}

func ==(lhs: Group, rhs: Group) -> Bool {
	return lhs.name == rhs.name
}