//
//  NutrientInfo.swift
//  Nutrition Analysis
//
//  Created by Nada Kamel on 24/03/2021.
//

import ObjectMapper

struct NutrientInfo {
    var uri: String?
    var label: String?
    var quantity: Double?
    var unit: String?
}

extension NutrientInfo: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        uri       <- map["uri"]
        label     <- map["label"]
        quantity  <- map["quantity"]
        unit      <- map["unit"]
    }
}
