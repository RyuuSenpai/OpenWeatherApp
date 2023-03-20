//
//  ForecastScreenEntity.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 18/03/2023.
//

import Foundation

struct ForecastScreenEntity {
    struct City {
        private let name: String
        private let country: String
        var fullName: String {
            name + ", " + country
        }
        var items = [Item]()
        public init(name: String,
                    country: String,
                    items: [Item]) {
            self.name = name
            self.country = country
            self.items = items
        }
    }

    struct Item: WeatherDetailsCellDataSource {
        // MARK: Properties
        let currentTemp: String
        let highestTemp: String
        let lowestTemp: String
        let weatherDetails: WeatherAdditionalDetailsDataSource
        let date: String
        var isExpanded = false
        // MARK: Init
        public init(currentTemp: String,
                    highestTemp: String,
                    lowestTemp: String,
                    weatherDetails: WeatherAdditionalDetailsDataSource,
                    date: String) {
            self.currentTemp = currentTemp
            self.highestTemp = highestTemp
            self.lowestTemp = lowestTemp
            self.weatherDetails = weatherDetails
            self.date = date.formattedDateTime()
        }
    }
}
