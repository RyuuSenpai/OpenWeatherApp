//
//  DashboardInteractorOutputMock.swift
//  OpenWeatherAppTests
//
//  Created by Eslam Abo El Fetouh on 15/03/2023.
//

import Foundation
@testable import OpenWeatherApp

class DashboardPresenterOutputMock: DashboardInteractorOutput {
    // MARK: - Properites
    var displayWeatherDataCalled = false
    var displayWeatherDataWeatherData: DashboardEntity.Weather?
    var requestDidFail = false
    var error: APIError?
    // MARK: - Methods
    func displayWeatherData(_ weatherData: DashboardEntity.Weather) {
        displayWeatherDataCalled = true
        displayWeatherDataWeatherData = weatherData
    }
    
    func failedToUpdateWeather(withError error: Error) {
        requestDidFail = true
        self.error = error as? APIError 
    }
}
