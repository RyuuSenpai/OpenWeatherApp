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
    case getWeatherBy(lat: Double, lng: Double)
    
    var path: String {
        switch self {
        case .weatherFor(let city):
            let city = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
            return Environment.dataMainVersion + "weather?q=\(city)"
        case .getWeatherBy(let lat,let lng) : return Environment.dataMainVersion + "forecast/daily?lat=\(lat)&lon=\(lng)&cnt=7&units=metric"
        }
    }
}
