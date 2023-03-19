//
//  ForecastLoader.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 19/03/2023.
//

import Foundation

protocol ForecastLoaderProtocol {
    func loadForecastData(for searchQuery: SearchQuery,
                                completionHandler: @escaping (APIResult<ForecastModel.Forecast>) -> Void)
}
final class ForecastLoader: ForecastLoaderProtocol, LoaderProtocol {
    typealias Entity = ForecastModel.Forecast

    // MARK: Call API Request
    func loadForecastData(for searchQuery: SearchQuery,
                          completionHandler: @escaping (APIResult<Entity>) -> Void) {
        let configuration = LoaderConfiguration(router: .forecast(searchQuery: searchQuery),
                                                method: .get)
        loadItems(requestConfiguration: configuration,
                  completionHandler: completionHandler)
    }
}
