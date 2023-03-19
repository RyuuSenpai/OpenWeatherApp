//
//  ForecastScreenInteractor.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 18/03/2023.
//

import Foundation
import CoreData
final class ForecastScreenInteractor {
    // MARK: - Properites
    var presenter: ForecastScreenInteractorOutput?
    var forecastLoader: ForecastLoaderProtocol?
    internal var searchHistoryItems = [SearchHistoryCoreDataItem]()
    init(forecastLoader: ForecastLoaderProtocol? = nil) {
        self.forecastLoader = forecastLoader
    }
    
}

// MARK: - Conforming to ForecastScreenPresenterInteractorProtocol
extension ForecastScreenInteractor: ForecastScreenPresenterInteractorProtocol {
    var maxSavedSearchCount: Int {
        5
    }

    func didSelectItem(_ item: SearchHistoryCollectionViewItemProtocol) {
        didSearhForQuery(searchQuery: .init(query: item.title))
    }

    func didFetchSearchHistoryList(with data: [SearchHistoryCollectionViewItemProtocol]) {
        self.presenter?.updateSearchHistoryList(with: data)
    }

    func didSearhForQuery(searchQuery: SearchQuery) {
        forecastLoader?.loadForecastData(for: searchQuery,
                                         completionHandler: { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let forecastData):
                // handle success case
                self.presenter?.didFetchForecast(data: forecastData)
                self.saveFetchedForecastData(forecastData)
            case .failure(let error):
                break
                // handle error case
//                self.presenter?.failedToUpdateWeather(withError: error)
            }
        })
    }
}
extension ForecastScreenInteractor {

}
extension SearchHistoryCoreDataItem: SearchHistoryCollectionViewItemProtocol {
    var title: String {
        self.fullTitle ?? ""
    }
}
