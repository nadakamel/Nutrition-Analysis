//
//  NutritionFactsViewController.swift
//  Nutrition Analysis
//
//  Created by Nada Kamel on 28/03/2021.
//

import UIKit

class NutritionFactsViewController: UIViewController {

    // MARK: Variables
    var totalCalories: Double = 0
    var totalDailyValues: Array<NutrientInfo> = []
    let criteria = ["Calories", "Fat", "Cholesterol", "Sodium", "Carbs", "Fiber", "Sugars", "Protein", "Vitamin A",
                       "Vitamin C", "Vitamin B6", "Vitamin B12", "Vitamin D", "Vitamin E", "Vitamin K"]
    var tableData: [(title: String, subtitle: String)] = []
    
    // MARK: Outlets
    @IBOutlet weak var totalDailyTableView: UITableView!
    
    // MARK: Properties
    lazy var emptyTableViewLabel: UILabel = {
        let label = UILabel(frame: totalDailyTableView.frame)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18.0)
        label.textColor = UIColor.darkGray
        label.text = "Nutrition Facts are not available"
        return label
    }()
    
    // MARK: - Configure Recipe TableView
    fileprivate func configTableView() {
        if (totalDailyValues.count == 0) {
            totalDailyTableView.backgroundView = emptyTableViewLabel
        } else {
            totalDailyTableView.backgroundView = nil
        }
        totalDailyTableView.tableFooterView = UIView()
        totalDailyTableView.reloadData()
    }

    fileprivate func loadData() {
        tableData.append(("Calories", String(totalCalories)))
        for nutrition in totalDailyValues {
            if let label = nutrition.label, criteria.contains(label) {
                let quantity = String(format: "%.2f", nutrition.quantity ?? 0)
                tableData.append((title: nutrition.label!,
                                  subtitle: "\(quantity) \(nutrition.unit ?? "")"))
            }
        }
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Nutrition Facts in Daily Basis"
        configTableView()
        loadData()
    }
    
}

extension NutritionFactsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NutritionFactsTableViewCell", for: indexPath)
        cell.textLabel?.text = tableData[indexPath.row].title
        cell.detailTextLabel?.text = tableData[indexPath.row].subtitle
        return cell
    }
}
