//
//  CustomCell.swift
//  iChef
//
//  Created by Benjamin San Soucie on 10/21/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

import Foundation
import UIKit

class CustomCell: UITableViewCell {
	@IBOutlet weak var name: UILabel!
	@IBOutlet weak var quantity: UILabel!
	@IBOutlet weak var attributes: UILabel!

	override init() {
		super.init()
		name.layer.borderColor = UIColor.blackColor().CGColor;
		name.layer.borderWidth = 3.0;
		println("CustomCell: setup border")
	}
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

}