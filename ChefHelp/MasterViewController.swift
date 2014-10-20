//
//  MasterViewController.swift
//  ChefHelp
//
//  Created by Maude on 10/19/14.
//  Copyright (c) 2014 Maude. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var recipes: [Recipe] = []


    override func awakeFromNib() {
        super.awakeFromNib()
        self.clearsSelectionOnViewWillAppear = false
        self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        feedRecipes()
        let controllers = self.splitViewController!.viewControllers
        self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
    }
    
    func feedRecipes() {
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
			Step(goal: "GREASE", ingredientsNeeded: [], time: 2, explanation: "grease the metal cake pan", timers: []),
			Step(goal: "FLOUR", ingredientsNeeded: [], time: 2, explanation: "flour the metal cake pan", timers: [])
			])
		
		let step2: Group = Group(name: "step 2", rest: [
			Step(goal: "WHISK", ingredientsNeeded: [flour, bakingPowder, cinnamon, bakingSoda, salt, nutmeg], time: 5, explanation: "whisk all together", timers: []),
			Step(goal: "BEAT", ingredientsNeeded: [sugar, brownSugar, eggs, oil, vanilla], time: 5, explanation: "beat together until smooth", timers: [5]),
			Step(goal: "MIX", ingredientsNeeded: [dryGroup, wetGroup], time: 5, explanation: "mix the dry ingredients and the liquids together until moistened", timers: [5]),
			Step(goal: "ADD", ingredientsNeeded: [carrots, pineapple, pecans], time: 3, explanation: "stir in these remaining ingredients", timers: []),
			Step(goal: "SPREAD", ingredientsNeeded: [cakeGroup], time: 1, explanation: "spread in prepared pan", timers: [])
			])
		
		let step3: Group = Group(name: "step 3", rest: [
			Step(goal: "BAKE", ingredientsNeeded: [cakeGroup], time: 35, explanation: "bake for 35min at 180C (350F)", timers: [35])
			])
		
		let step4: Group = Group(name: "step 4", rest: [
			Step(goal: "BEAT", ingredientsNeeded: [creamCheese, butter], time: 5, explanation: "beat cream chees and butter until smooth", timers: [5]),
			Step(goal: "ADD", ingredientsNeeded: [vanilla], time: 2, explanation: "beat in vanilla", timers: []),
			Step(goal: "ADD", ingredientsNeeded: [icingSugar], time: 2, explanation: "beat in icing sugar one third at the time", timers: []),
			Step(goal: "SPREAD", ingredientsNeeded: [icingGroup, cakeGroup], time: 1, explanation: "spread the whole mix on the top of the cake", timers: [])
			])
		
		let carrotCakeRecipe: Recipe = Recipe(recipeName: "carrot cake", ingredients: [cakeGroup, icingGroup], steps: [step1, step2, step3, step4],difficulty: Difficulty.Moderate)
		
		recipes.append(carrotCakeRecipe)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = recipes[indexPath.row]
				let controller = (segue.destinationViewController as UINavigationController).topViewController as DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
        if segue.identifier == "startCooking" {
            println("WOOOOo")
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        cell.textLabel?.text = recipes[indexPath.row].recipeName
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
}

