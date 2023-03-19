//
//  SearchLocationConfig.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 19/03/2023.
//

import Foundation

struct SearchQuery {
    enum InputType {
        case cityName(name: String),
             zipCode(value: String),
             coordinate(lat: String, lng: String),
             empty
    }

    let query: String
    var inputType: InputType {
        determineInputType(input: query)
    }
    // MARK: - Init
    init(query: String) {
        self.query = query
    }
    /// Get The type of the Query if Cityname, Coordinate, or zipCode
     private func determineInputType(input: String) -> InputType {
         if input.rangeOfCharacter(from: .letters) != nil {
             return .cityName(name: input)
         }
         guard input.rangeOfCharacter(from: .decimalDigits) != nil else {
             return .empty
         }
         if let lat = input.components(separatedBy: ",")[safe: 0],
            let lng = input.components(separatedBy: ",")[safe: 1] {
             return .coordinate(lat: lat, lng: lng)
         } else {
             return .zipCode(value: input)
         }
     }
}
