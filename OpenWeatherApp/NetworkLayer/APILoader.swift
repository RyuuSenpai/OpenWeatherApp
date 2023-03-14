//
//  APILoader.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 14/03/2023.
//

import Foundation

typealias ResultHandler<Entity: Codable> = ((APIResult<Entity>) -> Void)

struct LoaderConfiguration {
    let router: APIRouter
    let method: RequestMethod
}
protocol LoaderProtocol {
    associatedtype Entity: Codable
}

extension LoaderProtocol {
    func loadItems(requestConfiguration configuration: LoaderConfiguration,
                   completionHandler: @escaping ResultHandler<Entity>) {
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
