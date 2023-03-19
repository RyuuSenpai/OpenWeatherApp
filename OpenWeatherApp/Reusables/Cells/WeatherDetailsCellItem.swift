//
//  WeatherDetailsCellItem.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 19/03/2023.
//

import Foundation

protocol WeatherDetailsCellDataSource {
    var currentTemp: String { get }
    var highestTemp: String { get }
    var lowestTemp: String { get }
    var weatherDetails: WeatherAdditionalDetailsDataSource { get }
    var date: String { get }
    var isExpanded: Bool { get set }
}
