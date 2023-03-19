//
//  SearchHistoryCoreDataItem+CoreDataProperties.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 19/03/2023.
//
//

import Foundation
import CoreData


extension SearchHistoryCoreDataItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SearchHistoryCoreDataItem> {
        return NSFetchRequest<SearchHistoryCoreDataItem>(entityName: "SearchHistoryCoreDataItem")
    }

    @NSManaged public var city: String?
    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var country: String?
    @NSManaged public var isSelected: Bool
    @NSManaged public var fullTitle: String?

}

extension SearchHistoryCoreDataItem : Identifiable {

}
