//
//  API.swift
//  Nutrition Analysis
//
//  Created by Nada Kamel on 23/03/2021.
//

import Moya

let appID = "519faa56"
let appKey = "bd4df2e864121f9ae89af2d5036b0f61"

enum API {
    case recipeAnalysis(String, [String])
    case foodTextAnalysis(String)
}

extension API: TargetType {

    var baseURL: URL { return URL(string: "https://api.edamam.com/api/")!}
    
    var path: String {
        switch self {
        case .recipeAnalysis:
            return "nutrition-details"
        case .foodTextAnalysis:
            return "nutrition-data"
        }
    }
    
    var headers: [String:String]? {
       return ["Content-Type":"application/json"]
    }
    
    var method: Moya.Method {
        switch self {
        case .recipeAnalysis:
            return .post
        case .foodTextAnalysis:
            return .get
        }
    }
  
    var task: Task {
        var params = [String:String]()
        switch self {
        case .recipeAnalysis:
            params = ["app_id" : appID,
                      "app_key": appKey]
        case .foodTextAnalysis(let ingredientsEncoded):
            params = ["app_id" : appID,
                      "app_key": appKey,
                      "ingr": ingredientsEncoded]
        }
        switch self {
        case .recipeAnalysis:
            return .requestCompositeParameters(bodyParameters: bodyParameters, bodyEncoding: JSONEncoding.default, urlParameters: params)
        case .foodTextAnalysis:
            return .requestParameters(parameters: params , encoding: URLEncoding.default)
        }
    }
    
    var sampleData: Data {
        switch self {
        default:
            return Data()
        }
    }
    
    var bodyParameters: [String: Any] {
        switch self {
        case .recipeAnalysis(let title, let ingredients):
            return ["title": title, "ingr": ingredients]
        case .foodTextAnalysis(_):
            return ["":""]
        }
    }
}
