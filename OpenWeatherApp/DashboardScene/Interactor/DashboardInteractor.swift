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
            guard let self else { return }
            switch result {
            case .success(let weatherData):
                // handle success case
                self.presenter?.displayWeatherData(weatherData)
            case .failure(let error):
                // handle error case
                self.presenter?.failedToUpdateWeather(withError: error)
            }
        }
    }
}
// MARK: Conforming to DashboardPresenterInteractorProtocol
extension DashboardInteractor: DashboardPresenterInteractorProtocol {

}
