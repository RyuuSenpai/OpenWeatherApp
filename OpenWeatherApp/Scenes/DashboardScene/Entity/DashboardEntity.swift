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

    let showIcons: Bool

    var currentTemp: String {
        Int(temp.rounded()).stringValue
    }
    var cloudStateIconPath: URL? {
        cloudStateIconName.imageUrl
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
         humidityValue: Int,
         showIcons: Bool = true) {
        self.temp = currentTemp
        self.cloudsSate = cloudsSate
        self.cloudsStateDescription = cloudsStateDescription
        self.cloudStateIconName = cloudStateIconName
        self.windSpeedValue = windSpeedValue
        self.humidityValue = humidityValue
        self.showIcons = showIcons
    }

    init(_ weatherData: DashboardModel.Weather,
         showIcons: Bool = true) {
        self.temp = weatherData.main?.temp ?? 0.0
        self.cloudsSate = weatherData.weather?.first?.main ?? ""
        self.cloudsStateDescription = weatherData.weather?.first?.description ?? ""
        self.cloudStateIconName = weatherData.weather?.first?.icon ?? ""
        self.windSpeedValue = weatherData.wind?.speed ?? 0.0
        self.humidityValue = weatherData.main?.humidity ?? 0
        self.showIcons = showIcons
    }
}
