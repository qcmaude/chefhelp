//
//  ModelController.swift
//  ChefHelp
//
//  Created by Maude on 10/20/14.
//  Copyright (c) 2014 Maude. All rights reserved.
//

import UIKit

/*
A controller object that manages a simple model -- a collection of month names.

The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.

There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
*/


class ModelController: NSObject, UIPageViewControllerDataSource {
	var allSteps: [Group] = []
	
    override init() {
        super.init()

		self.loadData()
    }
	func loadData() {
		let nocolor = UIColor.whiteColor()
		let group1 = UIColor.yellowColor()
		let group2 = UIColor.cyanColor()
		let group3 = UIColor.redColor()
		let group4 = UIColor.greenColor()
		let group5 = UIColor.grayColor()
		let group6 = UIColor.magentaColor()
		
		let flour: Ingredient = Ingredient(name: "flour", attributes: "all-purpose", importance: Importance.MainIngredient, quantity: 2, unit: Unit.Cup, color: group1)
		let bakingPowder: Ingredient = Ingredient(name: "baking powder", attributes: "", importance: Importance.MainIngredient, quantity: 2, unit: Unit.TeaSpoon, color: group1)
		let cinnamon: Ingredient = Ingredient(name: "cinnamon", attributes: "", importance: Importance.SecondaryIngredient, quantity: 2, unit: Unit.TeaSpoon, color: group1)
		let bakingSoda: Ingredient = Ingredient(name: "baking soda", attributes: "", importance: Importance.MainIngredient, quantity: 1, unit: Unit.TeaSpoon, color: group1)
		let salt: Ingredient = Ingredient(name: "salt", attributes: "", importance: Importance.MainIngredient, quantity: 0.75, unit: Unit.TeaSpoon, color: group1)
		let nutmeg: Ingredient = Ingredient(name: "nutmeg", attributes: "", importance: Importance.SecondaryIngredient, quantity: 0.5, unit: Unit.TeaSpoon, color: group1)
		let sugar: Ingredient = Ingredient(name: "sugar", attributes: "granulated", importance: Importance.SecondaryIngredient, quantity: 0.75, unit: Unit.Cup, color: group2)
		let brownSugar: Ingredient = Ingredient(name: "brown sugar", attributes: "", importance: Importance.MainIngredient, quantity: 0.75, unit: Unit.Cup, color: group2)
		
		let dryGroup: Group = Group(name: "dry elements", rest: [flour, bakingPowder, cinnamon, bakingSoda, salt, nutmeg])
		
		
		let eggs: Ingredient = Ingredient(name: "eggs", attributes: "", importance: Importance.MainIngredient, quantity: 3, unit: Unit.Whole, color: group2)
		let oil: Ingredient = Ingredient(name: "oil", attributes: "vegetable", importance: Importance.MainIngredient, quantity: 0.75, unit: Unit.Cup, color: group2)
		let vanilla: Ingredient = Ingredient(name: "vanilla", attributes: "", importance: Importance.SecondaryIngredient, quantity: 1, unit: Unit.TeaSpoon, color: group2)
		
		let wetGroup: Group = Group(name: "wet elements", rest: [sugar, brownSugar, eggs, oil, vanilla])
		
		
		let carrots: Ingredient = Ingredient(name: "carrots", attributes: "grated", importance: Importance.MainIngredient, quantity: 2, unit: Unit.Cup, color: group3)
		let pineapple: Ingredient = Ingredient(name: "pineapple", attributes: "drained crushed canned", importance: Importance.SecondaryIngredient, quantity: 1, unit: Unit.Cup, color: group3)
		let pecans: Ingredient = Ingredient(name: "pecans", attributes: "chopped", importance: Importance.SecondaryIngredient, quantity: 0.5, unit: Unit.Cup, color: group3)
		
		let fillingGroup: Group = Group(name: "main", rest: [carrots, pineapple, pecans])
		
		
		let cakeGroup: Group = Group(name: "whole cake mix", rest: [dryGroup, wetGroup, fillingGroup])
		
		let creamCheese: Ingredient = Ingredient(name: "cream cheese", attributes: "softened", importance: Importance.MainIngredient, quantity: 250, unit: Unit.Gram, color: group4)
		let butter: Ingredient = Ingredient(name: "butter", attributes: "soften", importance: Importance.MainIngredient, quantity: 0.25, unit: Unit.Cup, color: group4)
		let vanilla2: Ingredient = Ingredient(name: "vanilla", attributes: "", importance: Importance.SecondaryIngredient, quantity: 0.5, unit: Unit.TeaSpoon, color: group5)
		let icingSugar: Ingredient = Ingredient(name: "icing sugar", attributes: "", importance: Importance.MainIngredient, quantity: 1, unit: Unit.Cup, color: group6)
		let icingGroup: Group = Group(name: "icing mix", rest: [creamCheese, butter, vanilla2, icingSugar])
		
		let step1: Group = Group(name: "step 1", rest: [
			Step(name: "GREASE", ingredientsNeeded: [], time: 2, explanation: "grease the metal cake pan", timers: [], color: UIColor.whiteColor()),
			Step(name: "FLOUR", ingredientsNeeded: [], time: 2, explanation: "flour the metal cake pan", timers: [], color: UIColor.whiteColor())
			])
		
		let step2: Group = Group(name: "step 2", rest: [
			Step(name: "WHISK", ingredientsNeeded: [flour, bakingPowder, cinnamon, bakingSoda, salt, nutmeg], time: 5, explanation: "whisk all together", timers: [], color: group1),
			Step(name: "BEAT", ingredientsNeeded: [sugar, brownSugar, eggs, oil, vanilla], time: 5, explanation: "beat together until smooth", timers: [5], color: group2),
			Step(name: "MIX", ingredientsNeeded: [dryGroup, wetGroup], time: 5, explanation: "mix the dry ingredients and the liquids together until moistened", timers: [5], color: nocolor),
			Step(name: "ADD", ingredientsNeeded: [carrots, pineapple, pecans], time: 3, explanation: "stir in these remaining ingredients", timers: [], color: group3),
			Step(name: "SPREAD", ingredientsNeeded: [cakeGroup], time: 1, explanation: "spread mixture in prepared pan", timers: [], color: nocolor)
			])
		
		let step3: Group = Group(name: "step 3", rest: [
			Step(name: "BAKE", ingredientsNeeded: [cakeGroup], time: 35, explanation: "bake for 35min at 180C (350F)", timers: [35], color: nocolor)
			])
		
		let step4: Group = Group(name: "step 4", rest: [
			Step(name: "BEAT", ingredientsNeeded: [creamCheese, butter], time: 5, explanation: "beat cream chees and butter until smooth", timers: [5], color: group4),
			Step(name: "ADD", ingredientsNeeded: [vanilla2], time: 2, explanation: "beat in vanilla", timers: [], color: group5),
			Step(name: "ADD", ingredientsNeeded: [icingSugar], time: 2, explanation: "beat in icing sugar one third at the time", timers: [], color: group6),
			Step(name: "SPREAD", ingredientsNeeded: [icingGroup, cakeGroup], time: 1, explanation: "spread the whole mix on the top of the cake", timers: [], color: nocolor)
			])
		
//		let carrotCakeRecipe: Recipe = Recipe(name: "Carrot Cake", ingredients: [cakeGroup, icingGroup], steps: [step1, step2, step3, step4],difficulty: Difficulty.Moderate)
		
//		self.allRecipes.append(carrotCakeRecipe)
		
		self.allSteps.append(step1)
		self.allSteps.append(step2)
		self.allSteps.append(step3)
		self.allSteps.append(step4)
	}
    
    func viewControllerAtIndex(index: Int, storyboard: UIStoryboard) -> DataViewController? {
        // Return the data view controller for the given index.
        if (self.allSteps.count == 0) || (index >= self.allSteps.count) {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        let dataViewController = storyboard.instantiateViewControllerWithIdentifier("DataViewController") as DataViewController
        dataViewController.step = self.allSteps[index]
        return dataViewController
    }
    
    func indexOfViewController(viewController: DataViewController) -> Int {
        // Return the index of the given data view controller.
        // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.

		if let step: Group = viewController.step {
			for (i, r) in enumerate(self.allSteps) {
				if r == step { return i; }
			}
            return NSNotFound
        } else {
            return NSNotFound
        }
    }
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as DataViewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
		
        index--
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as DataViewController)
        if index == NSNotFound {
            return nil
        }
        
        index++
        if index == self.allSteps.count {
            return nil
        }
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
}

