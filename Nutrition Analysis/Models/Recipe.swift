//
//  Recipe.swift
//  Nutrition Analysis
//
//  Created by Nada Kamel on 24/03/2021.
//

import ObjectMapper

struct Recipe {
    var uri: String?
    var yield: Int?
    var calories: Double?
    var totalWeight: Double?
    var dietLabels: [DietLabel]?
    var healthLabels: [HealthLabel]?
    var totalNutrients: [String:NutrientInfo]?
    var totalDaily: [String:NutrientInfo]?
    var ingredients: [Ingredient]?
}

extension Recipe: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        uri             <- map["uri"]
        yield           <- map["yield"]
        calories        <- map["calories"]
        totalWeight     <- map["totalWeight"]
        dietLabels      <- map["dietLabels"]
        healthLabels    <- map["healthLabels"]
        totalNutrients  <- map["totalNutrients"]
        totalDaily      <- map["totalDaily"]
        ingredients     <- map["ingredients"]
    }
}

enum DietLabel: String {
    case balanced = "BALANCED"
    case highProtein = "HIGH_PROTEIN"
    case highFiber = "HIGH_FIBER"
    case lowFat = "LOW_FAT"
    case lowCarb = "LOW_CARB"
    case lowSodium = "LOW_SODIUM"
}

enum HealthLabel: String {
    case vegan = "VEGAN"
    case vegetarian = "VEGETARIAN"
    case dairyFree = "DAIRY_FREE"
    case lowSugar = "LOW_SUGAR"
    case lowFatAbs = "LOW_FAT_ABS"
    case sugarConscious = "SUGAR_CONSCIOUS"
    case fatFree = "FAT_FREE"
    case glutenFree = "GLUTEN_FREE"
    case wheatFree = "WHEAT_FREE"
}
