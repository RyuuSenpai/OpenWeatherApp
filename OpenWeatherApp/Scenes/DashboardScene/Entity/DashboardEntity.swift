//
//  DashboardEntity.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 14/03/2023.
//

import Foundation

struct DashboardEntity: WeatherAdditionalDetailsDataSource {
    private let temp: Double
    let cloudsSate: String
    let cloudsStateDescription: String
    private let cloudStateIconName: String
    private let windSpeedValue: Double
    private let humidityValue: Int

    var currentTemp: String {
        Int(temp.rounded()).stringValue
    }
    var cloudStateIconPath: String {
        cloudStateIconName.imageUrlPath
    }
    var windSpeed: String {
        windSpeedValue.stringValue + "mile"
    }
    var humidity: String {
        humidityValue.stringValue + "%"
    }
    init(currentTemp: Double,
         cloudsSate: String,
         cloudsStateDescription: String,
         cloudStateIconName: String,
         windSpeedValue: Double,
         humidityValue: Int) {
        self.temp = currentTemp
        self.cloudsSate = cloudsSate
        self.cloudsStateDescription = cloudsStateDescription
        self.cloudStateIconName = cloudStateIconName
        self.windSpeedValue = windSpeedValue
        self.humidityValue = humidityValue
    }
}
