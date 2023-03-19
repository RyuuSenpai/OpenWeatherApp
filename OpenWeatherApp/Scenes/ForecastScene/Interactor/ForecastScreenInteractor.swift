//
//  ForecastScreenInteractor.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 18/03/2023.
//

import Foundation

final class ForecastScreenInteractor {
    // MARK: - Properites
    var presenter: ForecastScreenInteractorOutput?
    var forecastLoader: ForecastLoaderProtocol?

    init(forecastLoader: ForecastLoaderProtocol? = nil) {
        self.forecastLoader = forecastLoader
    }
    
}

// MARK: - Conforming to ForecastScreenPresenterInteractorProtocol
extension ForecastScreenInteractor: ForecastScreenPresenterInteractorProtocol {
    func didSearhForQuery(searchQuery: SearchQuery) {
        debugPrint("query: \(searchQuery.query), QueryType: \(searchQuery.inputType)")
        forecastLoader?.loadForecastData(for: searchQuery,
                                         completionHandler: { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let weatherData): break
                // handle success case
//                self.presenter?.didFetchCurrentWeatherData(weatherData)
            case .failure(let error): break
                // handle error case
//                self.presenter?.failedToUpdateWeather(withError: error)
            }
        })
    }
}
