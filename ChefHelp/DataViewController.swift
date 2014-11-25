//
//  DataViewController.swift
//  ChefHelp
//
//  Created by Maude on 10/20/14.
//  Copyright (c) 2014 Maude. All rights reserved.
//

import UIKit

class DataViewController: UIViewController, UITableViewDataSource {
    var step: Group?
	var ingredients: [Ingredient]?
	
	@IBOutlet weak var ingredientsNeeded: UITableView!
	@IBOutlet weak var stepsTodo: UITableView!
	@IBOutlet weak var stepName: UILabel!
    @IBOutlet weak var backOverview: UIButton!
    @IBOutlet weak var swipeRight: UILabel!
    @IBOutlet weak var swipeLeft: UILabel!
	@IBOutlet weak var timerButton: UIButton!
	@IBOutlet weak var timerLabel: UILabel!
	
	var runningTimer: NSTimer?
	var totalCountdownInterval: NSTimeInterval = 2101;
	var startDate = NSDate();
	var minutes = 35
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.ingredientsNeeded.registerNib(UINib(nibName: "CustomIngredientCell", bundle: nil), forCellReuseIdentifier: "ingredientsNeeded")
		self.ingredientsNeeded.rowHeight = 45
		self.stepsTodo.registerNib(UINib(nibName: "CustomStepCell", bundle: nil), forCellReuseIdentifier: "substeps")
		self.stepsTodo.rowHeight = 70
		timerButton.addTarget(self, action: Selector("timerOnTap:"), forControlEvents: .TouchUpInside)

        // Do any additional setup after loading the view, typically from a nib.
    }
	
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func timerOnTap(sender: UIButton!) {
		if runningTimer == nil {
			runningTimer = NSTimer(timeInterval:1.0, target:self, selector:Selector("timerDidTick:"), userInfo:nil, repeats: true);
			NSRunLoop.mainRunLoop().addTimer(runningTimer!, forMode: NSRunLoopCommonModes);
			let elapsedTime: NSTimeInterval = NSDate().timeIntervalSinceDate(startDate)
			let remainingTime = Int(floor(totalCountdownInterval - elapsedTime))
			
			if (remainingTime <= 0) {
				runningTimer!.invalidate()
				runningTimer = nil
				timerLabel.text = "Start \(minutes)min timer"
				return
			}
			let numberOfSeconds = remainingTime % 60
			let numberOfMinutes = remainingTime/60 % 60
			minutes = numberOfMinutes
			let numberOfHours = remainingTime/3600 % 24
			timerLabel.text = "\(numberOfHours)h \(numberOfMinutes)m \(numberOfSeconds)s"
		} else {
			runningTimer!.invalidate()
			runningTimer = nil
			timerLabel.text = "Start \(minutes)min timer"
		}
	}
	
	func timerDidTick(timer: NSTimer) {
		let elapsedTime: NSTimeInterval = NSDate().timeIntervalSinceDate(startDate)
		let remainingTime = Int(floor(totalCountdownInterval - elapsedTime))
		
		if (remainingTime <= 0) {
			runningTimer!.invalidate()
			runningTimer = nil
			timerLabel.text = "Start \(minutes)min timer"
			return
		}
		let numberOfSeconds = remainingTime % 60
		let numberOfMinutes = remainingTime/60 % 60
		minutes = numberOfMinutes
		let numberOfHours = remainingTime/3600 % 24
		timerLabel.text = "\(numberOfHours)h \(numberOfMinutes)m \(numberOfSeconds)s"
	}
	
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
		self.stepName.text = self.step!.name
        if step!.name == "Step 4" {
            swipeLeft.text = "Done!"
		} else if step!.name == "Step 1" {
			swipeRight.text = ""
		} else {
            swipeLeft.text = "Swipe left for next step"
			swipeRight.text = "Swipe right for previous step"
        }
		if(step!.name == "Step 3") {
			timerButton.backgroundColor = UIColor.redColor()
			timerLabel.text = "Start \(minutes)min timer"
		} else {
			timerButton.backgroundColor = UIColor.whiteColor()
			timerLabel.text = ""
		}
		self.ingredients = self.getAllIngredientsNeeded(self.step!.rest)
    }
	
//	func countAllIngredientsNeeded(steps: [GroupProtocol]) -> Int {
//		var count = 0
//		for i in steps {
//			if let s = i as? Step {
//				count += s.ingredientsNeeded.count
//			} else if let g = i as? Group {
//				count += countAllIngredientsNeeded(g.rest)
//			}
//		}
//		
//		return count
//	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if tableView == self.ingredientsNeeded {
			if self.ingredients == nil {
				self.ingredients = self.getAllIngredientsNeeded(self.step!.rest)
			}
			return self.ingredients!.count
		}
		
		if tableView == self.stepsTodo {
			return self.step!.rest.count
		}
		
		return 0
	}
	
	func getAllIngredientsNeeded(steps: [GroupProtocol]) -> [Ingredient] {
		var ingredients: [Ingredient] = []
		for i in steps {
			if let s = i as? Step {
				for ing in s.ingredientsNeeded {
					if let t = ing as? Ingredient {
						ingredients.append(t)
					}
				}
			} else if let g = i as? Group {
				ingredients.extend(getAllIngredientsNeeded(g.rest))
			}
		}
		
		return ingredients
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		if tableView == self.ingredientsNeeded {
			var cell:CustomIngredientCell = self.ingredientsNeeded.dequeueReusableCellWithIdentifier("ingredientsNeeded") as CustomIngredientCell
			if self.ingredients == nil {
				if let l = self.step? {
					self.ingredients = self.getAllIngredientsNeeded(l.rest)
				}
			}

			let ingredient = self.ingredients![indexPath.item]
			cell.name?.text = ingredient.name
			cell.quantity?.text = "\(ingredient.quantity) " + ingredient.unit.rawValue
			cell.backgroundColor = ingredient.color

			return cell
		}
		
		var cell:CustomStepCell = self.stepsTodo.dequeueReusableCellWithIdentifier("substeps") as CustomStepCell
		let substep = self.step?.rest[indexPath.item] as Step
		cell.name?.text = substep.name
		cell.explanation?.text = substep.explanation
		cell.time?.text = "\(substep.time) min"
		cell.color1.backgroundColor = substep.color1
		cell.color2.backgroundColor = substep.color2
		cell.color1.layer.cornerRadius = 20
		cell.color2.layer.cornerRadius = 20
		return cell
	}
}

