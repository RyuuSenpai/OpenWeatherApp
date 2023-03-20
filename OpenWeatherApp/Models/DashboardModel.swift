//
//  DashboardModel.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 19/03/2023.
//

import Foundation

struct DashboardModel {
    // MARK: - Weather
    struct Weather: Codable {
        let coord: Coord?
        let weather: [WeatherDescription]?
        let base: String?
        let main: Main?
        let visibility: Int?
        let wind: Wind?
        let clouds: Clouds?
        let dt: Int?
        let sys: Sys?
        let timezone, id: Int?
        let name: String?
        let cod: Int?
    }

    // MARK: - Clouds
    struct Clouds: Codable {
        let all: Int?
    }

    // MARK: - Coord
    struct Coord: Codable {
        let lon, lat: Double?
    }

    // MARK: - Main
    struct Main: Codable {
        let temp, feelsLike, tempMin, tempMax: Double?
        let pressure, humidity, seaLevel, grndLevel: Int?

        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case pressure, humidity
            case seaLevel = "sea_level"
            case grndLevel = "grnd_level"
        }
    }

    // MARK: - Sys
    struct Sys: Codable {
        let country: String?
        let sunrise, sunset: Int?
    }

    // MARK: - WeatherDescription
    struct WeatherDescription: Codable {
        let id: Int?
        let main, description, icon: String?
    }

    // MARK: - Wind
    struct Wind: Codable {
        let speed: Double?
        let deg: Int?
        let gust: Double?
    }
}
extension DashboardModel.Weather: WeatherSearhResultInput {
    var cityName: String {
        self.name ?? ""
    }

    var country: String {
        self.sys?.country ?? ""
    }

    var fullTitle: String {
        cityName + ", " + country
    }

    var lat: Double {
        coord?.lat ?? 0.0
    }

    var lon: Double {
        coord?.lon ?? 0.0
    }
}
