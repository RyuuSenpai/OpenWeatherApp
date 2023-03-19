//
//  CurrentWeatherLoader.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 20/03/2023.
//

import Foundation

protocol WeatherQueryLoaderProtocol {
    func loadWeatherData(with query: SearchQuery,
                                completionHandler: @escaping (APIResult<DashboardModel.Weather>) -> Void)
}
final class WeatherQueryLoader: WeatherQueryLoaderProtocol, LoaderProtocol {
    typealias Entity = DashboardModel.Weather

    // MARK: Call API Request
    func loadWeatherData(with query: SearchQuery,
                         completionHandler: @escaping (APIResult<Entity>) -> Void) {
        let configuration = LoaderConfiguration(router: .weather(searchQuery: query),
                                                method: .get)
        loadItems(requestConfiguration: configuration,
                  completionHandler: completionHandler)
    }
}
