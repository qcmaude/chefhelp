//
//  ViewController.swift
//  iChef
//
//  Created by Benjamin San Soucie on 10/20/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate {
	@IBOutlet weak var table: UITableView!
	@IBOutlet weak var allIngredients: UITableView!
	@IBOutlet weak var recipeTile: UILabel!
	
	var filteredRecipes: [Recipe] = []
	var allRecipes: [Recipe] = []
	var selectedRecipeIngredients: [Ingredient] = []
	var selectedRecipe: Recipe?
	var results: [[String]] = []
	
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
		self.searchDisplayController!.searchResultsTableView.registerNib(UINib(nibName: "CustomFilteredRecipeCell", bundle: nil), forCellReuseIdentifier: "filteredRecipes")

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
		let nocolor = UIColor.whiteColor()
		let group1 = UIColor(red: 222.0/255.0, green: 152.0/255.0, blue: 170.0/255.0, alpha: 1.0)
		let group2 = UIColor(red: 244.0/255.0, green: 204.0/255.0, blue: 124.0/255.0, alpha: 1.0)
		let group3 = UIColor(red: 237.0/255.0, green: 175.0/255.0, blue: 136.0/255.0, alpha: 1.0)
		let group4 = UIColor(red: 213.0/255.0, green: 192.0/255.0, blue: 182.0/255.0, alpha: 1.0)
		let group5 = UIColor(red: 174.0/255.0, green: 218.0/255.0, blue: 215.0/255.0, alpha: 1.0)
		let group6 = UIColor(red: 222.0/255.0, green: 152.0/255.0, blue: 170.0/255.0, alpha: 1.0)
		
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
		
		let wholeCake: Ingredient = Ingredient(name: "whole cake", attributes: "", importance: Importance.MainIngredient, quantity: 1, unit: Unit.Whole, color: group1)
		
		let step1: Group = Group(name: "Step 1", rest: [
			Step(name: "GREASE", ingredientsNeeded: [butter], time: 2, explanation: "grease the metal cake pan", timers: [], color1: group4, color2: nocolor),
			Step(name: "FLOUR", ingredientsNeeded: [flour], time: 2, explanation: "flour the metal cake pan", timers: [], color1: group1, color2: nocolor)
			])
		
		let step2: Group = Group(name: "Step 2", rest: [
			Step(name: "WHISK", ingredientsNeeded: [flour, bakingPowder, cinnamon, bakingSoda, salt, nutmeg], time: 5, explanation: "whisk all together", timers: [], color1: group1, color2: nocolor),
			Step(name: "BEAT", ingredientsNeeded: [sugar, brownSugar, eggs, oil, vanilla], time: 5, explanation: "beat together until smooth", timers: [5], color1: group2, color2: nocolor),
			Step(name: "MIX", ingredientsNeeded: [dryGroup, wetGroup], time: 5, explanation: "mix the dry ingredients and the liquids together until moistened", timers: [5], color1: group1, color2: group2),
			Step(name: "ADD", ingredientsNeeded: [carrots, pineapple, pecans], time: 3, explanation: "stir in these remaining ingredients", timers: [], color1: group3, color2: nocolor),
			Step(name: "SPREAD", ingredientsNeeded: [cakeGroup], time: 1, explanation: "spread mixture in prepared pan", timers: [], color1: nocolor, color2: nocolor)
			])
		
		let step3: Group = Group(name: "Step 3", rest: [
			Step(name: "BAKE", ingredientsNeeded: [wholeCake], time: 35, explanation: "bake for 35min at 180C (350F)", timers: [35], color1: group1, color2: nocolor)
			])
		
		let step4: Group = Group(name: "Step 4", rest: [
			Step(name: "BEAT", ingredientsNeeded: [creamCheese, butter], time: 5, explanation: "beat cream chees and butter until smooth", timers: [5], color1: group4, color2: nocolor),
			Step(name: "ADD", ingredientsNeeded: [vanilla2], time: 2, explanation: "beat in vanilla", timers: [], color1: group5, color2: nocolor),
			Step(name: "ADD", ingredientsNeeded: [icingSugar], time: 2, explanation: "beat in icing sugar one third at the time", timers: [], color1: group6, color2: nocolor),
			Step(name: "SPREAD", ingredientsNeeded: [icingGroup, cakeGroup], time: 1, explanation: "spread the whole mix on the top of the cake", timers: [], color1: nocolor, color2: nocolor)
			])
		
		let carrotCakeRecipe: Recipe = Recipe(name: "Carrot Cake", ingredients: [cakeGroup, icingGroup], steps: [step1, step2, step3, step4],difficulty: Difficulty.Moderate)

		self.allRecipes.append(carrotCakeRecipe)
	}
	
	func filterContentForSearchText(searchText: String) {
		// Filter the array using the filter method
		self.filteredRecipes = self.allRecipes.filter({( recipe: Recipe) -> Bool in
			let stringMatch = recipe.name.rangeOfString(searchText)
			let ingredientsMatch = self.generateIngredientList(recipe).filter({(ingredient: Ingredient) -> Bool in
				return ingredient.name.rangeOfString(searchText) != nil && ingredient.importance == Importance.MainIngredient
			})
			if stringMatch != nil || ingredientsMatch.count > 0 {
				self.results += [["name: \(recipe.name)"]]
			}
//			if stringMatch != nil || ingredientsMatch.count > 0 {
//				var arr = []
//				for i in ingredientsMatch {
//					arr.add
//				}
//				results.append(arr)
//			}
			return stringMatch != nil || ingredientsMatch.count > 0
		})
	}
	func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
		self.filterContentForSearchText(searchString)
		return true
	}
 
	func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
		self.filterContentForSearchText(self.searchDisplayController!.searchBar.text)
		return true
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch tableView {
		case self.searchDisplayController!.searchResultsTableView:
			return self.filteredRecipes.count
		case self.allIngredients:
			return self.selectedRecipeIngredients.count
		default:
			return self.allRecipes.count
		}
	}
	
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		switch tableView {
		case self.searchDisplayController!.searchResultsTableView:
			var cell:CustomFilteredRecipeCell = self.searchDisplayController!.searchResultsTableView.dequeueReusableCellWithIdentifier("filteredRecipes") as CustomFilteredRecipeCell
			if(self.selectedRecipe! == self.filteredRecipes[indexPath.row]) {
				cell.backgroundColor = UIColor(red: (20.0/255.0), green: (100.0/255.0), blue: (200.0/255.0), alpha: 0.5)
			} else {
				cell.backgroundColor = UIColor.whiteColor()
			}
			
			cell.name?.text = self.filteredRecipes[indexPath.row].name
			cell.time?.text = "\(self.getTime(self.filteredRecipes[indexPath.row])) min"
			if(self.results[indexPath.row].count > 0) {
				cell.result1?.text = "\(self.results[indexPath.row][0])"
			}
			
			cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
			return cell
		case self.table:
			var cell:CustomRecipeCell = self.table.dequeueReusableCellWithIdentifier("recipes") as CustomRecipeCell
			if(self.selectedRecipe! == self.allRecipes[indexPath.row]) {
				cell.backgroundColor = UIColor(red: (20.0/255.0), green: (100.0/255.0), blue: (200.0/255.0), alpha: 0.5)
			} else {
				cell.backgroundColor = UIColor.whiteColor()
			}
			
			cell.name?.text = self.allRecipes[indexPath.row].name
			cell.time?.text = "\(self.getTime(self.allRecipes[indexPath.row])) min"
			return cell
		default:
			var cell:CustomCell = self.allIngredients.dequeueReusableCellWithIdentifier("ingredients") as CustomCell
			
			cell.name?.text = self.selectedRecipeIngredients[indexPath.row].name
			cell.quantity?.text = "\(self.selectedRecipeIngredients[indexPath.row].quantity) " + self.selectedRecipeIngredients[indexPath.row].unit.rawValue
			cell.attributes?.text = self.selectedRecipeIngredients[indexPath.row].attributes
			
			cell.name?.textColor = UIColor.blackColor().colorWithAlphaComponent(0.40)
			cell.quantity?.textColor = UIColor.blackColor().colorWithAlphaComponent(0.40)
			cell.attributes?.textColor = UIColor.blackColor().colorWithAlphaComponent(0.40)
			
			let allCells = self.allIngredients.visibleCells() as [CustomCell]
			for c in allCells {
				c.name?.textColor = UIColor.blackColor()
				c.quantity?.textColor = UIColor.blackColor()
				c.attributes?.textColor = UIColor.blackColor()
			}
			
			if allCells.count > 1 && indexPath.row != 8 && indexPath.row != 9 {
				let color1 = UIColor.blackColor().colorWithAlphaComponent(0.60)
				let color2 = UIColor.blackColor().colorWithAlphaComponent(0.40)
				
				allCells[allCells.count - 1].name?.textColor = color1
				allCells[allCells.count - 1].quantity?.textColor = color1
				allCells[allCells.count - 1].attributes?.textColor = color1
				
				allCells[allCells.count - 2].name?.textColor = color2
				allCells[allCells.count - 2].quantity?.textColor = color2
				allCells[allCells.count - 2].attributes?.textColor = color2
			}

//			
//			if allCells.count > 3 {
//				let color1 = UIColor.blackColor().colorWithAlphaComponent(0.40)
//				let color2 = UIColor.blackColor().colorWithAlphaComponent(0.60)
//				let color3 = UIColor.blackColor().colorWithAlphaComponent(0.80)
//				allCells[allCells.count - 1].name?.textColor = color1
//				allCells[allCells.count - 1].quantity?.textColor = color1
//				allCells[allCells.count - 1].attributes?.textColor = color1
//				
//				allCells[allCells.count - 2].name?.textColor = color2
//				allCells[allCells.count - 2].quantity?.textColor = color2
//				allCells[allCells.count - 2].attributes?.textColor = color2
//				
//				allCells[allCells.count - 3].name?.textColor = color3
//				allCells[allCells.count - 3].quantity?.textColor = color3
//				allCells[allCells.count - 3].attributes?.textColor = color3
//			}
			return cell
		}
	}

	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		switch tableView {
		case self.searchDisplayController!.searchResultsTableView:
			println("selected from search")
			var cell:CustomRecipeCell = self.table.dequeueReusableCellWithIdentifier("recipes") as CustomRecipeCell
			self.selectedRecipeIngredients = self.generateIngredientList(self.filteredRecipes[indexPath.item])
			self.recipeTile.text = self.filteredRecipes[indexPath.item].name
			self.allIngredients.reloadData()
			self.table.reloadData()
			self.searchDisplayController!.setActive(false, animated: true)
		default:
			var cell:CustomRecipeCell = self.table.dequeueReusableCellWithIdentifier("recipes") as CustomRecipeCell
			self.selectedRecipeIngredients = self.generateIngredientList(self.allRecipes[indexPath.item])
			self.recipeTile.text = self.allRecipes[indexPath.item].name
			self.allIngredients.reloadData()
			self.table.reloadData()
		}
		
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

