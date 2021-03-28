//
//  RecipeViewController.swift
//  Nutrition Analysis
//
//  Created by Nada Kamel on 23/03/2021.
//

import UIKit
import RxSwift

class RecipeViewController: UIViewController {

    // MARK: Routes
    enum RecipeRoute: String {
        case recipeSummary
    }
    
    // MARK: Variables
    var router: RecipeRouter!
    let viewModel = RecipeViewModel()
    var disposeBag = DisposeBag()
    
    // MARK: Outlets
    @IBOutlet weak var ingredientsTextView: CustomTextView!
    @IBOutlet weak var analyzeButton: CustomButton!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Nutrition Analysis"
        router = DefaultRecipeRouter(viewController: self)
        ingredientsTextView.delegate = self
    }
    
    // MARK: - Navigation
    fileprivate func navigateToRecipeSummaryVC() {
        router.navigate(to: .recipeSummary)
    }
    
    // MARK: - Buttons Target-action methods
    @IBAction func analyzeButtonTapped(_ sender: UIButton) {
        print(ingredientsTextView.text ?? "")
        var ingredientsList: [String] = []
        let lines = ingredientsTextView.text.split(whereSeparator: \.isNewline)
        for line in lines {
            ingredientsList.append(String(line))
        }
        viewModel.getRecipeAnalysis(title: "", ingredients: ingredientsList)
        viewModel.recipe.subscribe { (recipe) in
            if recipe.element?.uri != nil {
                self.navigateToRecipeSummaryVC()
            }
        }
        .disposed(by: disposeBag)
    }
    
    @IBAction func newRecipeButtonTapped(_ sender: UIButton) {
        ingredientsTextView.text = nil
        analyzeButton.isEnabled = false
    }
    
}

// MARK: - UITextView Delegate
extension RecipeViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if !textView.text.isEmpty {
            analyzeButton.isEnabled = true
        } else {
            analyzeButton.isEnabled = false
        }
    }
}
