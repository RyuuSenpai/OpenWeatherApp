//
//  APILoader.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 14/03/2023.
//

import Foundation

typealias ResultHandler<Entity: Codable> = ((APIResult<Entity>) -> Void)
protocol Loader {
    associatedtype Entity: Codable
    func loadItems(completionHandler: @escaping ResultHandler<Entity>)}

protocol LoaderInput: Loader {
    init(configuration: LoaderConfiguration)
}
struct LoaderConfiguration {
    let router: APIRouter
    let method: RequestMethod
    
}
class MainItemsLoader<Entity: Codable>: LoaderInput {
    // MARK: Properties
    let configuration: LoaderConfiguration
    // MARK: Init
    required init(configuration: LoaderConfiguration) {
        self.configuration = configuration
    }
}

extension MainItemsLoader {
    func loadItems(completionHandler: @escaping ResultHandler<Entity>) {
        APIClient.shared.performRequest(router: configuration.router,
                                        method: configuration.method) { (result: APIResult<Entity>) in
            switch result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
