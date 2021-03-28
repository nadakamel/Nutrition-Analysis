//
//  RecipeSummaryViewController.swift
//  Nutrition Analysis
//
//  Created by Nada Kamel on 26/03/2021.
//

import UIKit

class RecipeSummaryViewController: UIViewController {
    
    // MARK: Routes
    enum RecipeSummaryRoute: String {
        case nutritionFacts
    }
    
    // MARK: Variables
    var router: RecipeSummaryRouter!
    var recipe = Recipe()
    let tableTitles = ["Quantity", "Unit", "Food", "Weight"]
    
//    static let rice = Parsed(quantity: 1, measure: "cup", foodMatch: "rice", food: "rice", foodID: "FOOD_0253", weight: 195, retainedWeight: 195)
//    static let chickpeas = Parsed(quantity: 10, measure: "ounce", foodMatch: "chickpeas", food: "chickpeas", foodID: "FOOD_0424", weight: 283.5, retainedWeight: 283.5)
//    let ingredients: [Ingredient] = [Ingredient(text: "1 cup rice", parsed: [rice]),
//                                     Ingredient(text: "10 oz chickpeas", parsed: [chickpeas])]
    
    // MARK: Outlets
    @IBOutlet weak var recipeTableView: UITableView!
    
    // MARK: Properties
    lazy var emptyTableViewLabel: UILabel = {
        let label = UILabel(frame: recipeTableView.frame)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18.0)
        label.textColor = UIColor.darkGray
        label.text = "No ingredients found!\n\nYou need to upgrade your plan to Enterprise Core"
        return label
    }()
    
    // MARK: - Configure Recipe TableView
    fileprivate func configTableView() {
        if (recipe.ingredients == nil) {
            recipeTableView.backgroundView = emptyTableViewLabel
        } else {
            recipeTableView.backgroundView = nil
        }
        recipeTableView.tableFooterView = UIView()
        recipeTableView.reloadData()
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ingredients List"
        router = DefaultRecipeSummaryRouter(viewController: self)
        configTableView()
    }
    
    // MARK: - Buttons Target-action methods
    
    @IBAction func showNutritionFactsBtnTapped(_ sender: UIButton) {
        router.navigate(to: .nutritionFacts)
    }
    
}

extension RecipeSummaryViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return recipe.ingredients?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeSummaryTableViewCell", for: indexPath)
        if let recipe = recipe.ingredients?[indexPath.section].parsed?[0]  {
            cell.textLabel?.text = tableTitles[indexPath.row]
            switch indexPath.row {
            case 0:
                cell.detailTextLabel?.text = "\(recipe.quantity ?? 0)"
            case 1:
                cell.detailTextLabel?.text = recipe.measure
            case 2:
                cell.detailTextLabel?.text = recipe.foodMatch
            default:
                cell.detailTextLabel?.text = "\(recipe.weight ?? 0) g"
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return recipe.ingredients?[section].text
    }
}
