//
//  DashboardPresenter.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 14/03/2023.
//

import Foundation

final class DashboardPresenter {
    // MARK: - Properites
    private var view: DashboardControllerProtocol?
    private var interactor: DashboardPresenterInteractorProtocol?
    private var router: DashboardRouterProtocol?
    private var userLocation: (latitude: Double, longitude: Double)?
    // MARK: - Init
    init(view: DashboardControllerProtocol?,
         interactor: DashboardPresenterInteractorProtocol?,
         router: DashboardRouterProtocol?) {
        self.view = view
        self.interactor = interactor
    }
}
// MARK: - Conforming to DashboardPresenterProtocol
extension DashboardPresenter: DashboardPresenterProtocol {
    func viewDidLoad() {
        interactor?.getUserCurrentLocation()
    }
}
// MARK: - Conforming to DashboardInteractorOutput
extension DashboardPresenter: DashboardInteractorOutput {
    // MARK: UserLocationUpdates
    func getUserCurrentLocation(latitude: Double, longitude: Double) {
        self.userLocation = (latitude, longitude)
        self.interactor?.fetchWeatherData(for: latitude, longitude)
    }
    // MARK: API Delegates
    func displayWeatherData(_ weatherData: DashboardEntity.Weather) {
    }
    
    func failedToUpdateWeather(withError error: Error) {
        
    }
}
