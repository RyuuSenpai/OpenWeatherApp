//
//  APIError.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 15/03/2023.
//

import Foundation

enum APIError: Error, Equatable {
    case badRequest
    case unauthorized
    case serverError
    case didnotSetExpectedResult
}
