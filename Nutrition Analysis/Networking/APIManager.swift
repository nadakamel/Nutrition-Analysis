//
//  APIManager.swift
//  Nutrition Analysis
//
//  Created by Nada Kamel on 23/03/2021.
//

import RxSwift
import Moya
import ObjectMapper
import Moya_ObjectMapper

extension Response {
    func getResultsFromData() -> Response {
        guard let json = try? self.mapJSON() as? Dictionary<String, AnyObject>,
              let newData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) else {
                return self
        }
        let newResponse = Response(statusCode: self.statusCode,
                                   data: newData,
                                   response: self.response)
        return newResponse
    }
}

struct APIManager {
    let provider: MoyaProvider<API>
    let disposeBag = DisposeBag()
    
    init() {
        provider = MoyaProvider<API>()
    }
}

extension APIManager {
    typealias AddAction = (() -> ())

    fileprivate func request<T: Mappable>(_ token: API, type: T.Type,
                                  completion: @escaping (Result<T, Error>)->Void,
                                  additionalSteps:  AddAction? = nil) {
        provider.rx.request(token)
            .debug()
            .map { response -> Response in
                return response.getResultsFromData()
            }
            .mapObject(T.self)
            .subscribe { event -> Void in
                switch event {
                case .success(let parsedObject):
                    completion(.success(parsedObject))
                    additionalSteps?()
                case .error(let error):
                    completion(.failure(error))
                }
            }.disposed(by: disposeBag)
    }
}

protocol APICalls {
    func recipeAnalysis(title: String!, ingredients: [String], completion: @escaping (Result<Recipe, Error>) -> Void)
    func foodTextAnalysis(ingredient: String!, completion: @escaping (Result<Recipe, Error>) -> Void)
}

extension APIManager: APICalls {
    func recipeAnalysis(title: String!, ingredients: [String], completion: @escaping (Result<Recipe, Error>) -> Void) {
        request(.recipeAnalysis(title, ingredients), type: Recipe.self, completion: completion)
    }

    func foodTextAnalysis(ingredient: String!, completion: @escaping (Result<Recipe, Error>) -> Void) {
        request(.foodTextAnalysis(ingredient), type: Recipe.self, completion: completion)
    }
}
