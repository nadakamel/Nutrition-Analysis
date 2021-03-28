//
//  Ingredient.swift
//  Nutrition Analysis
//
//  Created by Nada Kamel on 28/03/2021.
//

import ObjectMapper

// MARK: - Ingredient
struct Ingredient {
    var text: String?
    var parsed: [Parsed]?
}

extension Ingredient: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        text       <- map["text"]
        parsed     <- map["parsed"]
    }
}

// MARK: - Parsed
struct Parsed {
    var quantity: Int?
    var measure, foodMatch, food, foodID: String?
    var weight, retainedWeight: Double?
}

extension Parsed: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        quantity        <- map["quantity"]
        measure         <- map["measure"]
        foodMatch       <- map["foodMatch"]
        food            <- map["food"]
        foodID          <- map["foodId"]
        weight          <- map["weight"]
        retainedWeight  <- map["retainedWeight"]
    }
}
