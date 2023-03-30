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
    var coreDataManager: CoreDataManagerProtocol?
    internal var searchHistoryItems = [SearchHistoryCoreDataItem]()
    internal var didFetchCoreDataOnce = false
    init(forecastLoader: ForecastLoaderProtocol? = nil,
         coreDataManager: CoreDataManagerProtocol?) {
        self.forecastLoader = forecastLoader
        self.coreDataManager = coreDataManager
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

    func refreshData() {
        didSearhForQuery(searchQuery: .init(query: searchHistoryItems.last?.title ?? ""))
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
