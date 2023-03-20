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
    private var unitOfMeasurement: APIClient.UnitsOfMeasurement = .celsius
    private var lastSearchedQuery: SearchQuery?
    // MARK: Init
    init(weatherLoader: WeatherQueryLoaderProtocol?) {
        self.weatherLoader = weatherLoader
    }
}
extension CurrentWeatherInteractor: CurrentWeatherPresenterInteractorProtocol {

    func switchUnitOfMeasurement() {
        unitOfMeasurement = unitOfMeasurement == .celsius ? .fahrenheit : .celsius
        guard let lastSearchedQuery = lastSearchedQuery else { return }
        searhForQuery(searchQuery: lastSearchedQuery)
    }
    // MARK: - Handle Search
    var maxSavedSearchCount: Int {
        10
    }

    func didFetchSearchHistoryList(with data: [SearchHistoryCollectionViewItemProtocol]) {
        self.presenter?.updateSearchHistoryList(with: data)
    }

    func didSearhForQuery(searchQuery: SearchQuery) {
        searhForQuery(searchQuery: searchQuery,
                         saveResultToCoreData: true)
    }
    private func searhForQuery(searchQuery: SearchQuery,
                                  saveResultToCoreData save: Bool = true) {
        self.lastSearchedQuery = searchQuery
        weatherLoader?.loadWeatherData(with: searchQuery,
                                       unitOfMeasurement: unitOfMeasurement,
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
        searhForQuery(searchQuery: .init(query: query),
                         saveResultToCoreData: false)
    }
    func saveCoreDataItems() {
        CoreDataManager.shared.saveContext()
    }

    private func handleWeatherResponse(result: APIResult<DashboardModel.Weather>,
                                       saveResultToCoreData: Bool = true) {
        switch result {
        case .success(let weatherData):
            // handle success case
            self.presenter?.didFetchWeatherData(weatherData,
                                                unitOfMeasurement: self.unitOfMeasurement)
            guard saveResultToCoreData else { return }
            self.saveFetchedForecastData(weatherData)
        case .failure(_): break
        }
    }
}

