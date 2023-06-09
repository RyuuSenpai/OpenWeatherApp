//
//  SearchHistoryCoreDataInteractor.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 19/03/2023.
//

import Foundation
import CoreData

protocol SearchHistoryCoreDataInteractorProtocol: AnyObject {
    var searchHistoryItems: [SearchHistoryCoreDataItem] { get set }
    var didFetchCoreDataOnce: Bool { get set }
    func didFetchSearchHistoryList(with data: [SearchHistoryCollectionViewItemProtocol])
    func didSearhForQuery(searchQuery: SearchQuery)
    var maxSavedSearchCount: Int { get }
    var coreDataManager: CoreDataManagerProtocol? { get }
}

protocol WeatherSearhResultInput {
    var cityName: String { get }
    var country: String { get }
    var fullTitle: String { get }
    var lat: Double { get }
    var lon: Double { get }
}
extension SearchHistoryCoreDataInteractorProtocol {

    func fetchSearchHistory() {
        searchHistoryItems = coreDataManager?.fetch(entityType: SearchHistoryCoreDataItem.self) ?? []
        self.handleFirstListFetch(didFetchCoreDataOnce)
        resetSelectionForListAndSelectLastAdded()
        // Reverse Items order, to make the last searched item at the top of the list
        didFetchSearchHistoryList(with: self.searchHistoryItems.reversed())
    }
    private func resetSelectionForListAndSelectLastAdded() {
        searchHistoryItems.forEach { $0.isSelected = false }
        searchHistoryItems.last?.isSelected = true
    }
    private func handleFirstListFetch(_ didFetchCoreDataOnce: Bool) {
        guard !didFetchCoreDataOnce,
              let cityTitle = searchHistoryItems.last?.title else { return }
        self.didFetchCoreDataOnce = true
        self.didSearhForQuery(searchQuery: .init(query: cityTitle))
    }
    func saveFetchedForecastData(_ data: WeatherSearhResultInput) {

        defer {
            // SaveContext and FetchAllData
            coreDataManager?.saveContext()
            fetchSearchHistory()
        }
        handleExistingItemCase(data)
       guard let searchHistoryItem = createSearchHistoryItem(fullTitle: data.fullTitle,
                                                        cityName: data.cityName,
                                                        country: data.country,
                                                        lat: data.lat,
                                                             lon: data.lon)  else { return }
        handleSearchHistoryLimit()
        coreDataManager?.saveObject(searchHistoryItem)
    }

    private func handleExistingItemCase(_ data: WeatherSearhResultInput) {
        guard let index = searchHistoryItems.firstIndex(where: { $0.fullTitle == data.fullTitle }) else { return }
        let existingItem = searchHistoryItems[index]
        coreDataManager?.delete(existingItem, andSave: false)
        searchHistoryItems.remove(at: index)
    }
    private func createSearchHistoryItem(fullTitle: String,
                                         cityName: String,
                                         country: String,
                                         lat: Double,
                                         lon: Double) -> SearchHistoryCoreDataItem? {
        guard let coreDataManager = coreDataManager,
              let searchHistoryItem = NSEntityDescription.insertNewObject(forEntityName: CoreDataEntity.searchHistoryItem.rawValue,
                                                                          into: coreDataManager.persistentContainer.viewContext) as? SearchHistoryCoreDataItem else {
            return nil
        }
        searchHistoryItem.isSelected = true
        searchHistoryItem.fullTitle = fullTitle
        searchHistoryItem.city = cityName
        searchHistoryItem.country = country
        searchHistoryItem.lat = lat
        searchHistoryItem.lon = lon
        return searchHistoryItem
    }

    private func handleSearchHistoryLimit() {
        guard searchHistoryItems.count >= maxSavedSearchCount, let firstItem = searchHistoryItems.first else {
            return
        }
        coreDataManager?.delete(firstItem, andSave: false)
        searchHistoryItems.remove(at: .zero)
    }
}
