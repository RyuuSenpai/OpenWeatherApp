//
//  CurrentWeatherInteractor.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 19/03/2023.
//

import Foundation

class CurrentWeatherInteractor {

    var presenter: CurrentWeatherInteractorOutput?

    init() {
    }
}
extension CurrentWeatherInteractor: CurrentWeatherPresenterInteractorProtocol {
    func getUserCurrentLocation() {
        
    }

    func fetchWeatherData(for latitude: Double, _ longitude: Double) {

    }
}

