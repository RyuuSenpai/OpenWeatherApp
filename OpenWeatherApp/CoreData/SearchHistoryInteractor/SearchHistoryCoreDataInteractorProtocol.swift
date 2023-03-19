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
    func updateSearchHistoryList(with data: [SearchHistoryCollectionViewItemProtocol])
    var maxSavedSearchCount: Int { get }
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
        searchHistoryItems = CoreDataManager.shared.fetch(entityType: SearchHistoryCoreDataItem.self) ?? []
        updateSearchHistoryList(with: self.searchHistoryItems.reversed())
    }

    func saveFetchedForecastData(_ data: WeatherSearhResultInput) {

        let existingItem = searchHistoryItems.first(where: { $0.fullTitle == data.fullTitle })

        if let existingItem = existingItem {
            existingItem.isSelected = true
        } else {
            let searchHistoryItem = createSearchHistoryItem(fullTitle: data.fullTitle,
                                                            cityName: data.cityName,
                                                            country: data.country,
                                                            lat: data.lat,
                                                            lon: data.lon)
            handleSearchHistoryLimit()
            CoreDataManager.shared.saveObject(searchHistoryItem)
        }

        CoreDataManager.shared.saveContext()
        fetchSearchHistory()
    }

    private func createSearchHistoryItem(fullTitle: String,
                                         cityName: String,
                                         country: String,
                                         lat: Double,
                                         lon: Double) -> SearchHistoryCoreDataItem {
        let searchHistoryItem = NSEntityDescription.insertNewObject(forEntityName: CoreDataEntity.searchHistoryItem.rawValue, into: CoreDataManager.shared.persistentContainer.viewContext) as! SearchHistoryCoreDataItem
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
        CoreDataManager.shared.delete(firstItem, andSave: false)
        searchHistoryItems.remove(at: .zero)
    }
}
