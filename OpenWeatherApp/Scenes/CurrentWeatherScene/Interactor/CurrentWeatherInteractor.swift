//
//  CurrentWeatherInteractor.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 19/03/2023.
//

import Foundation

class CurrentWeatherInteractor {

    var presenter: CurrentWeatherInteractorOutput?
    private var weatherLoader: WeatherQueryLoaderProtocol?
    // MARK: Init
    init(weatherLoader: WeatherQueryLoaderProtocol?) {
        self.weatherLoader = weatherLoader
    }
}
extension CurrentWeatherInteractor: CurrentWeatherPresenterInteractorProtocol {
    func getUserCurrentLocation(with coordinates: CurrentWeatherSceneBuilderInput) {
        let query = coordinates.lat + ", " + coordinates.lon
        weatherLoader?.loadWeatherData(with: .init(query: query),
                                       completionHandler: { [weak self] result in
            guard let self else { return }
            self.handleWeatherResponse(result: result)
        })
    }

    private func handleWeatherResponse(result: APIResult<DashboardModel.Weather>) {
        switch result {
        case .success(let weatherData):
            // handle success case
            self.presenter?.didFetchWeatherData(weatherData)
        case .failure(let error):
            // handle error case
            self.presenter?.failedToUpdateWeather(withError: error)
        }
    }
    func fetchWeatherData(for latitude: Double, _ longitude: Double) {

    }
}

