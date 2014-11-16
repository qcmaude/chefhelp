//
//  ViewController.swift
//  iChef
//
//  Created by Benjamin San Soucie on 10/20/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	@IBOutlet weak var table: UITableView!
	@IBOutlet weak var allIngredients: UITableView!
	@IBOutlet weak var recipeTile: UILabel!
	
	var allRecipes: [Recipe] = []
	var selectedRecipeIngredients: [Ingredient] = []
	var selectedRecipe: Recipe?
	
	override init() {
		super.init()
		self.loadData()
	}

	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.loadData()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.allIngredients.registerNib(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "ingredients")
		self.table.registerNib(UINib(nibName: "CustomRecipeCell", bundle: nil), forCellReuseIdentifier: "recipes")

		self.table.dataSource = self
		self.table.delegate = self
		
		self.allIngredients.dataSource = self
		
		self.setDefaults()
		
		self.table.reloadData()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources		that can be recreated.
	}
	
	func setDefaults() {
		self.selectedRecipe = self.allRecipes[0]
		self.selectedRecipeIngredients = self.generateIngredientList(self.selectedRecipe!)
		self.recipeTile.text = self.selectedRecipe!.name
	}
	
	func loadData() {
		let flour: Ingredient = Ingredient(name: "flour", attributes: "all-purpose", importance: Importance.MainIngredient, quantity: 2, unit: Unit.Cup)
		let bakingPowder: Ingredient = Ingredient(name: "baking powder", attributes: "", importance: Importance.MainIngredient, quantity: 2, unit: Unit.TeaSpoon)
		let cinnamon: Ingredient = Ingredient(name: "cinnamon", attributes: "", importance: Importance.SecondaryIngredient, quantity: 2, unit: Unit.TeaSpoon)
		let bakingSoda: Ingredient = Ingredient(name: "baking soda", attributes: "", importance: Importance.MainIngredient, quantity: 1, unit: Unit.TeaSpoon)
		let salt: Ingredient = Ingredient(name: "salt", attributes: "", importance: Importance.MainIngredient, quantity: 0.75, unit: Unit.TeaSpoon)
		let nutmeg: Ingredient = Ingredient(name: "nutmeg", attributes: "", importance: Importance.SecondaryIngredient, quantity: 0.5, unit: Unit.TeaSpoon)
		let sugar: Ingredient = Ingredient(name: "sugar", attributes: "granulated", importance: Importance.SecondaryIngredient, quantity: 0.75, unit: Unit.Cup)
		let brownSugar: Ingredient = Ingredient(name: "brown sugar", attributes: "", importance: Importance.MainIngredient, quantity: 0.75, unit: Unit.Cup)
		
		let dryGroup: Group = Group(name: "dry elements", rest: [flour, bakingPowder, cinnamon, bakingSoda, salt, nutmeg])
		
		
		let eggs: Ingredient = Ingredient(name: "eggs", attributes: "", importance: Importance.MainIngredient, quantity: 3, unit: Unit.Whole)
		let oil: Ingredient = Ingredient(name: "oil", attributes: "vegetable", importance: Importance.MainIngredient, quantity: 0.75, unit: Unit.Cup)
		let vanilla: Ingredient = Ingredient(name: "vanilla", attributes: "", importance: Importance.SecondaryIngredient, quantity: 1, unit: Unit.TeaSpoon)
		
		let wetGroup: Group = Group(name: "wet elements", rest: [sugar, brownSugar, eggs, oil, vanilla])
		
		
		let carrots: Ingredient = Ingredient(name: "carrots", attributes: "grated", importance: Importance.MainIngredient, quantity: 2, unit: Unit.Cup)
		let pineapple: Ingredient = Ingredient(name: "pineapple", attributes: "drained crushed canned", importance: Importance.SecondaryIngredient, quantity: 1, unit: Unit.Cup)
		let pecans: Ingredient = Ingredient(name: "pecans", attributes: "chopped", importance: Importance.SecondaryIngredient, quantity: 0.5, unit: Unit.Cup)
		
		let fillingGroup: Group = Group(name: "main", rest: [carrots, pineapple, pecans])
		
		
		let cakeGroup: Group = Group(name: "whole cake mix", rest: [dryGroup, wetGroup, fillingGroup])
		
		let creamCheese: Ingredient = Ingredient(name: "cream cheese", attributes: "softened", importance: Importance.MainIngredient, quantity: 250, unit: Unit.Gram)
		let butter: Ingredient = Ingredient(name: "butter", attributes: "soften", importance: Importance.MainIngredient, quantity: 0.25, unit: Unit.Cup)
		let vanilla2: Ingredient = Ingredient(name: "vanilla", attributes: "", importance: Importance.SecondaryIngredient, quantity: 0.5, unit: Unit.TeaSpoon)
		let icingSugar: Ingredient = Ingredient(name: "icing sugar", attributes: "", importance: Importance.MainIngredient, quantity: 1, unit: Unit.Cup)
		let icingGroup: Group = Group(name: "icing mix", rest: [creamCheese, butter, vanilla2, icingSugar])
		
		let step1: Group = Group(name: "step 1", rest: [
			Step(name: "GREASE", ingredientsNeeded: [], time: 2, explanation: "grease the metal cake pan", timers: []),
			Step(name: "FLOUR", ingredientsNeeded: [], time: 2, explanation: "flour the metal cake pan", timers: [])
			])
		
		let step2: Group = Group(name: "step 2", rest: [
			Step(name: "WHISK", ingredientsNeeded: [flour, bakingPowder, cinnamon, bakingSoda, salt, nutmeg], time: 5, explanation: "whisk all together", timers: []),
			Step(name: "BEAT", ingredientsNeeded: [sugar, brownSugar, eggs, oil, vanilla], time: 5, explanation: "beat together until smooth", timers: [5]),
			Step(name: "MIX", ingredientsNeeded: [dryGroup, wetGroup], time: 5, explanation: "mix the dry ingredients and the liquids together until moistened", timers: [5]),
			Step(name: "ADD", ingredientsNeeded: [carrots, pineapple, pecans], time: 3, explanation: "stir in these remaining ingredients", timers: []),
			Step(name: "SPREAD", ingredientsNeeded: [cakeGroup], time: 1, explanation: "spread in prepared pan", timers: [])
			])
		
		let step3: Group = Group(name: "step 3", rest: [
			Step(name: "BAKE", ingredientsNeeded: [cakeGroup], time: 35, explanation: "bake for 35min at 180C (350F)", timers: [35])
			])
		
		let step4: Group = Group(name: "step 4", rest: [
			Step(name: "BEAT", ingredientsNeeded: [creamCheese, butter], time: 5, explanation: "beat cream chees and butter until smooth", timers: [5]),
			Step(name: "ADD", ingredientsNeeded: [vanilla], time: 2, explanation: "beat in vanilla", timers: []),
			Step(name: "ADD", ingredientsNeeded: [icingSugar], time: 2, explanation: "beat in icing sugar one third at the time", timers: []),
			Step(name: "SPREAD", ingredientsNeeded: [icingGroup, cakeGroup], time: 1, explanation: "spread the whole mix on the top of the cake", timers: [])
			])
		
		let carrotCakeRecipe: Recipe = Recipe(name: "Carrot Cake", ingredients: [cakeGroup, icingGroup], steps: [step1, step2, step3, step4],difficulty: Difficulty.Moderate)

		self.allRecipes.append(carrotCakeRecipe)
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if tableView == self.allIngredients {
			return self.selectedRecipeIngredients.count
		}
		
		if tableView == self.table {
			return self.allRecipes.count
		}
		
		return 0
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		switch tableView {
		case self.table:
			var cell:CustomRecipeCell = self.table.dequeueReusableCellWithIdentifier("recipes") as CustomRecipeCell
			if let r = self.selectedRecipe? {
				if(r == self.allRecipes[indexPath.row]) {
					cell.backgroundColor = UIColor.blueColor()
				} else {
					cell.backgroundColor = UIColor.whiteColor()
				}
			}
			
			cell.name?.text = self.allRecipes[indexPath.row].name
			cell.time?.text = "\(self.getTime(self.allRecipes[indexPath.row])) min"
			return cell
		default:
			var cell:CustomCell = self.allIngredients.dequeueReusableCellWithIdentifier("ingredients") as CustomCell
			
			cell.name?.text = self.selectedRecipeIngredients[indexPath.row].name
			cell.quantity?.text = "\(self.selectedRecipeIngredients[indexPath.row].quantity) " + self.selectedRecipeIngredients[indexPath.row].unit.rawValue
			cell.attributes?.text = self.selectedRecipeIngredients[indexPath.row].attributes
			return cell
		}
	}

	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		var cell:CustomRecipeCell = self.table.dequeueReusableCellWithIdentifier("recipes") as CustomRecipeCell
		self.selectedRecipeIngredients = self.generateIngredientList(self.allRecipes[indexPath.item])
		self.recipeTile.text = self.allRecipes[indexPath.item].name
		self.allIngredients.reloadData()
		self.table.reloadData()
//		let recipeSelected: Recipe = self.allRecipes[indexPath.item]
//		let ingredients: [Ingredient] = self.generateIngredientList(recipeSelected)
//		
//		recipeTile.text = recipeSelected.name
		
//		for ingredient in ingredients {
//			var ingredientCell:CustomCell = self.allIngredients.dequeueReusableCellWithIdentifier("ingredients") as CustomCell
//			ingredientCell.name?.text = ingredient.name
//			ingredientCell.quantity?.text = "\(ingredient.quantity)" + ingredient.unit.toRaw()
//			ingredientCell.attributes?.text = ingredient.attributes
//			self.allIngredients.addSubview(ingredientCell)
//		}
	}
	
	func getTime(recipe: Recipe) -> Int {
		var total: Int = 0
		var todo: [GroupProtocol] = recipe.steps
		
		while todo.count > 0 {
			let step = todo.removeLast()
			if let s = step as? Step  {
				total += s.time
			} else if let g = step as? Group {
				for part in g.rest {
					todo.insert(part, atIndex: 0)
				}
			}
		}
		return total

	}
	
	func generateIngredientList(recipe: Recipe) -> [Ingredient] {
		var allIngredients: [Ingredient] = []
		var todo: [GroupProtocol] = recipe.ingredients
		
		while todo.count > 0 {
			let ing = todo.removeLast()
			if let i = ing as? Ingredient  {
				allIngredients.append(i)
			} else if let g = ing as? Group {
				for part in g.rest {
					todo.insert(part, atIndex: 0)
				}
			}
		}
		return allIngredients
	}
}

