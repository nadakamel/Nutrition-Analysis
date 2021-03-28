//
//  RecipeViewController.swift
//  Nutrition Analysis
//
//  Created by Nada Kamel on 23/03/2021.
//

import UIKit
import RxSwift

class RecipeViewController: UIViewController {

    @IBOutlet weak var ingredientsTextView: CustomTextView!
    @IBOutlet weak var analyzeButton: CustomButton!
    
    let viewModel = RecipeViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Nutrition Analysis"
        ingredientsTextView.delegate = self
    }
    
    func navigateToRecipeSummaryVC() {
        guard let nextController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RecipeSummaryViewController") as? RecipeSummaryViewController else {
            return
        }
        nextController.viewModel = viewModel
        self.navigationController?.pushViewController(nextController, animated: true)
    }
    
    @IBAction func analyzeButtonTapped(_ sender: UIButton) {
        print(ingredientsTextView.text ?? "")
        var ingredientsList: [String] = []
        let lines = ingredientsTextView.text.split(whereSeparator: \.isNewline)
        for line in lines {
            ingredientsList.append(String(line))
        }
        viewModel.getRecipeAnalysis(title: "", ingredients: ingredientsList)
        viewModel.recipe.asObservable().subscribe { (recipe) in
            self.navigateToRecipeSummaryVC()
        }
        .disposed(by: disposeBag)
    }
    
    @IBAction func newRecipeButtonTapped(_ sender: UIButton) {
        ingredientsTextView.text = nil
        analyzeButton.isEnabled = false
        analyzeButton.backgroundColor = .lightGray
        analyzeButton.setTitleColor(.white, for: .normal)
        analyzeButton.borderColor = .white
    }
    
}

extension RecipeViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if !textView.text.isEmpty {
            analyzeButton.isEnabled = true
            analyzeButton.backgroundColor = .white
            analyzeButton.setTitleColor(.systemGreen, for: .normal)
            analyzeButton.borderColor = .systemGreen
        } else {
            analyzeButton.isEnabled = false
            analyzeButton.backgroundColor = .lightGray
            analyzeButton.setTitleColor(.white, for: .normal)
            analyzeButton.borderColor = .lightGray
        }
    }
}
