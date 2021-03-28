//
//  RecipeRouter.swift
//  Nutrition Analysis
//
//  Created by Nada Kamel on 26/03/2021.
//

import UIKit

protocol RecipeRouter {
    typealias Route = RecipeViewController.RecipeRoute
    
    var viewController: RecipeViewController! { get }
    init(viewController: RecipeViewController)
    
    func navigate(to route: Route)
}

class DefaultRecipeRouter: RecipeRouter {
    
    weak var viewController: RecipeViewController!
    
    required init(viewController: RecipeViewController) {
        self.viewController = viewController
    }
    
    func navigate(to route: Route) {
        switch route {
        case .recipeSummary:
            passDataToRecipeSummary(route)
        }
    }
    
}

// MARK: - Extension for passing data logic
extension DefaultRecipeRouter {
    private func passDataToRecipeSummary(_ route: Route) {
        guard let recipeSummaryVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: route.rawValue) as? RecipeSummaryViewController else { return }
        recipeSummaryVC.recipe = viewController.viewModel.recipe.value
        viewController.navigationController?.pushViewController(recipeSummaryVC, animated: true)
    }
}
