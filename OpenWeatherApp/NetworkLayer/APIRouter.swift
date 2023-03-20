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
    case getCurrentWeatherBy(lat: Double, lng: Double)
    case weather(searchQuery: SearchQuery,
                 unitOfMeasurement: APIClient.UnitsOfMeasurement)
    case forecast(searchQuery: SearchQuery)
    // MARK: Get Endpoint
    var path: String {
        var units = APIClient.UnitsOfMeasurement.celsius.rawValue
        switch self {
        case .getCurrentWeatherBy(let lat,let lng) :
            return Environment.dataMainVersion + "weather?lat=\(lat)&lon=\(lng)" + units
        case .weather(let searchQuery, let unitOfMeasurement):
            units = unitOfMeasurement.rawValue
            return EndPoint.weather(searchQuery: searchQuery).path + units
        case .forecast(let searchQuery):
            return EndPoint.forecast(searchQuery: searchQuery).path + units
        }
    }
}
// MARK: ForecastEndpoint
extension APIRouter {
    enum EndPoint {
        case forecast(searchQuery: SearchQuery)
        case weather(searchQuery: SearchQuery)

        var path: String {
            var base = Environment.dataMainVersion
            let searchQuery: SearchQuery
            switch self {
            case .forecast(let query):
                base += "forecast?"
                searchQuery = query
            case .weather(let query):
                base += "weather?"
                searchQuery = query
            }
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
// MARK: Unit of length
extension APIClient.UnitsOfMeasurement {
    var unitOfLength: String {
        switch self {
        case .fahrenheit:
            return "Mile"
        case .celsius:
            return "K/h"
        }
    }
}
