//
//  APIRouter.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 14/03/2023.
//

import Foundation

fileprivate class Environment {
    static var dataMainVersion: String {
        return "/data/2.5/"
    }
}
enum APIRouter {
    case weatherFor(city: String)
    case getCurrentWeatherBy(lat: Double, lng: Double)
    case forecast(searchQuery: SearchQuery)
    // MARK: Get Endpoint
    var path: String {
        let units = "&units=metric"
        switch self {
        case .weatherFor(let city):
            let city = city.urlHostCharactersAllowed
            return Environment.dataMainVersion + "weather?q=\(city)" + units
        case .getCurrentWeatherBy(let lat,let lng) :
            return Environment.dataMainVersion + "weather?lat=\(lat)&lon=\(lng)" + units
            // MARK: - Forecast
        case .forecast(let searchQuery):
            return ForecastEndpoint(searchQuery: searchQuery).path + units
        }
    }
}
// MARK: ForecastEndpoint
extension APIRouter {
    struct ForecastEndpoint {
        let searchQuery: SearchQuery

        var path: String {
            let base = Environment.dataMainVersion + "forecast?"
            switch searchQuery.inputType {
            case .coordinate(let lat, let lon):
                return base + "lat=\(lat)&lon=\(lon)"
            case .zipCode(let value):
                return base + "zip=\(value)"
            default:
                return base + "q=\(searchQuery.query.urlHostCharactersAllowed)"
            }
        }
    }
}
