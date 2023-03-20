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
    internal var searchHistoryItems = [SearchHistoryCoreDataItem]()
    internal var didFetchCoreDataOnce = false
    // MARK: Init
    init(weatherLoader: WeatherQueryLoaderProtocol?) {
        self.weatherLoader = weatherLoader
    }
}
extension CurrentWeatherInteractor: CurrentWeatherPresenterInteractorProtocol {
    // MARK: - Handle Search
    var maxSavedSearchCount: Int {
        10
    }

    func didFetchSearchHistoryList(with data: [SearchHistoryCollectionViewItemProtocol]) {
        self.presenter?.updateSearchHistoryList(with: data)
    }

    func didSearhForQuery(searchQuery: SearchQuery) {
        didSearhForQuery(searchQuery: searchQuery,
                         saveResultToCoreData: true)
    }
    private func didSearhForQuery(searchQuery: SearchQuery,
                          saveResultToCoreData save: Bool = true) {
        weatherLoader?.loadWeatherData(with: searchQuery,
                                       completionHandler: { [weak self] result in
            guard let self else { return }
            self.handleWeatherResponse(result: result,
                                       saveResultToCoreData: save)
        })
    }

    func didSelectItem(_ item: SearchHistoryCollectionViewItemProtocol) {
        didSearhForQuery(searchQuery: .init(query: item.title))
    }

    func getUserCurrentLocationWeatherData(with coordinates: CurrentWeatherSceneBuilderInput) {
        let query = coordinates.lat + ", " + coordinates.lon
        didSearhForQuery(searchQuery: .init(query: query),
                         saveResultToCoreData: false)
    }

    private func handleWeatherResponse(result: APIResult<DashboardModel.Weather>,
                                       saveResultToCoreData: Bool = true) {
        switch result {
        case .success(let weatherData):
            // handle success case
            self.presenter?.didFetchWeatherData(weatherData)
            guard saveResultToCoreData else { return }
            self.saveFetchedForecastData(weatherData)
        case .failure(let error):
            // handle error case
            self.presenter?.failedToUpdateWeather(withError: error)
        }
    }
}

