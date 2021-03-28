//
//  RecipeViewModel.swift
//  Nutrition Analysis
//
//  Created by Nada Kamel on 24/03/2021.
//

import Foundation
import RxSwift
import RxCocoa

class RecipeViewModel {
    
    let recipe: BehaviorRelay<Recipe> = BehaviorRelay(value: Recipe())
    private var apiManager: APICalls = APIManager()
    
    public func getRecipeAnalysis(title: String!, ingredients: [String]) {
        apiManager.recipeAnalysis(title: title, ingredients: ingredients) { [weak self] (response) in
            switch response {
            case .success(let result):
                self?.recipe.accept(result)
            case .failure(let error):
                print("error: \(error.localizedDescription)")
            }
        }
    }
    
}
