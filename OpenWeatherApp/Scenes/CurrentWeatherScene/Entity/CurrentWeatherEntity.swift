//
//  CurrentWeatherEntity.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 20/03/2023.
//

import Foundation

struct CurrentWeatherEntity {
    let weatherBaseData: DashboardEntity
    let highestTemp: String
    let lowestTemp: String
    let cityName: String
}
