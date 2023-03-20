//
//  ForecastModel.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 19/03/2023.
//

import Foundation

public struct ForecastModel {
    // MARK: - Forecast
    struct Forecast: Codable {
        let cod: String?
        let message, cnt: Int?
        let list: [WeatherDetails]?
        let city: City?
    }

    // MARK: - City
    struct City: Codable {
        let id: Int?
        let name: String?
        let coord: DashboardModel.Coord?
        let country: String?
        let population, timezone, sunrise, sunset: Int?
    }

    // MARK: - List
    struct WeatherDetails: Codable {
        let dt: Int?
        let main: MainClass?
        let weather: [DashboardModel.WeatherDescription]?
        let clouds: Clouds?
        let wind: DashboardModel.Wind?
        let visibility: Int?
        let pop: Double?
        let sys: DashboardModel.Sys?
        let dtTxt: String?
        let rain: Rain?

        enum CodingKeys: String, CodingKey {
            case dt, main, weather, clouds, wind, visibility, pop, sys
            case dtTxt = "dt_txt"
            case rain
        }
    }

    // MARK: - Clouds
    struct Clouds: Codable {
        let all: Int?
    }

    // MARK: - MainClass
    struct MainClass: Codable {
        let temp, feelsLike, tempMin, tempMax: Double?
        let pressure, seaLevel, grndLevel, humidity: Int?
        let tempKf: Double?

        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case pressure
            case seaLevel = "sea_level"
            case grndLevel = "grnd_level"
            case humidity
            case tempKf = "temp_kf"
        }
    }

    // MARK: - Rain
    struct Rain: Codable {
        let the3H: Double?

        enum CodingKeys: String, CodingKey {
            case the3H = "3h"
        }
    }
}
// MARK: Make ForecastModel.Forecast Conform to WeatherSearhResultInput
extension ForecastModel.Forecast: WeatherSearhResultInput {
    var cityName: String {
        city?.name ?? ""
    }

    var country: String {
        city?.country ?? ""
    }

    var fullTitle: String {
        cityName + ", " + country
    }

    var lat: Double {
        city?.coord?.lat ?? 0.0
    }

    var lon: Double {
        city?.coord?.lon ?? 0.0
    }
}
