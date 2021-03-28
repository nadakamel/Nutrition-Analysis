//
//  RecipeSummaryRouter.swift
//  Nutrition Analysis
//
//  Created by Nada Kamel on 28/03/2021.
//

import UIKit

protocol RecipeSummaryRouter {
    typealias Route = RecipeSummaryViewController.RecipeSummaryRoute
    
    var viewController: RecipeSummaryViewController! { get }
    init(viewController: RecipeSummaryViewController)
    
    func navigate(to route: Route)
}

class DefaultRecipeSummaryRouter: RecipeSummaryRouter {
    var viewController: RecipeSummaryViewController!
    
    required init(viewController: RecipeSummaryViewController) {
        self.viewController = viewController
    }
    
    func navigate(to route: Route) {
        switch route {
        case .nutritionFacts:
            passDataToNutritionFacts(route)
        }
    }
    
}

// MARK: - Extension for passing data logic
extension DefaultRecipeSummaryRouter {
    private func passDataToNutritionFacts(_ route: Route) {
        guard let nutritionFactsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: route.rawValue) as? NutritionFactsViewController else { return }
        if let totalDaily = viewController.recipe.totalDaily {
            nutritionFactsVC.totalDailyValues = Array(totalDaily.values)
        } else {
            nutritionFactsVC.totalDailyValues = []
        }
        nutritionFactsVC.totalCalories = viewController.recipe.calories ?? 0
        viewController.navigationController?.pushViewController(nutritionFactsVC, animated: true)
    }
}
