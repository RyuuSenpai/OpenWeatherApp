//
//  WeatherLoaderProtocolMock.swift
//  OpenWeatherAppTests
//
//  Created by Eslam Abo El Fetouh on 15/03/2023.
//

import Foundation
@testable import OpenWeatherApp

// MARK: - WeatherLoaderProtocolMock
class WeatherLoaderMock: WeatherLoaderProtocol {
    // MARK: - Properites
    var loadWeatherCalled = false
    var expectedResult: APIResult<DashboardEntity.Weather>?
    // MARK: - Methods
    func loadWeather(with latitude: Double, _ longitude: Double, completionHandler: @escaping (APIResult<DashboardEntity.Weather>) -> Void) {
        loadWeatherCalled = true
        guard let result = expectedResult else {
            completionHandler(.failure(APIError.didnotSetExpectedResult))
            return
        }
        completionHandler(result)
    }
}
