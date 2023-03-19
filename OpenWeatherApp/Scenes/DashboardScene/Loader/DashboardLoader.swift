//
//  DashboardLoader.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 14/03/2023.
//

import Foundation
import CoreLocation

protocol WeatherLoaderProtocol {
    func loadCurrentWeatherData(with latitude: Double,
                                _ longitude: Double,
                                completionHandler: @escaping (APIResult<DashboardModel.Weather>) -> Void)
}
final class WeatherLoader: WeatherLoaderProtocol, LoaderProtocol {
    typealias Entity = DashboardModel.Weather
    
    // MARK: Call API Request
    func loadCurrentWeatherData(with latitude: Double,
                                _ longitude: Double,
                                completionHandler: @escaping (APIResult<Entity>) -> Void) {
        let configuration = LoaderConfiguration(router: .getCurrentWeatherBy(lat: latitude,
                                                                             lng: longitude),
                                                method: .get)
        loadItems(requestConfiguration: configuration,
                  completionHandler: completionHandler)
    }
}
