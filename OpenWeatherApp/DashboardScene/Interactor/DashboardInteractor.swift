//
//  DashboardInteractor.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 14/03/2023.
//

import Foundation
import CoreLocation

final class DashboardInteractor {
    // MARK: - Properites
    weak var presenter: DashboardInteractorOutput?
    private let weatherLoader: WeatherLoaderProtocol

    init(weatherLoader: WeatherLoaderProtocol) {
        self.weatherLoader = weatherLoader
    }
}
// MARK: Conforming to DashboardPresenterInteractorProtocol
extension DashboardInteractor {
    func fetchWeatherData(with latitude: Double,
                          _ longitude: Double) {
        weatherLoader.loadWeather(with: latitude, longitude) { [weak self] result in
            switch result {
            case .success(let weatherData): break
                // handle success case
            case .failure(let error): break
                // handle error case
            }
        }
    }
}
// MARK: Conforming to DashboardPresenterInteractorProtocol
extension DashboardInteractor: DashboardPresenterInteractorProtocol {

}
