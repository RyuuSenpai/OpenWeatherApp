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
        self.router = router
    }
}
// MARK: - Conforming to DashboardPresenterProtocol
extension DashboardPresenter: DashboardPresenterProtocol {
    func navigateToForecastScreen() {
        router?.navigateToForecastScreen()
    }

    func navigateToCurrentWeatherScreen() {
    }

    func viewDidLoad() {
        interactor?.getUserCurrentLocation()
    }
}
// MARK: - Conforming to DashboardInteractorOutput
extension DashboardPresenter: DashboardInteractorOutput {
    // MARK: UserLocationUpdates
    func loadaUserCurrentWeather(byLocation latitude: Double, _ longitude: Double) {
        self.userLocation = (latitude, longitude)
        self.interactor?.fetchWeatherData(for: latitude, longitude)
    }
    // MARK: API Delegates
    func didFetchCurrentWeatherData(_ weatherData: DashboardEntity.Weather) {
        let item = CurrentWeatherItemDetails(currentTemp: weatherData.main?.temp ?? 0.0,
                                             cloudsSate: weatherData.weather?.first?.main ?? "",
                                             cloudsStateDescription: weatherData.weather?.first?.description ?? "",

                                             cloudStateIconName: weatherData.weather?.first?.icon ?? "",
                                             windSpeedValue: weatherData.wind?.speed ?? 0.0,
                                             humidityValue: weatherData.main?.humidity ?? 0)
        view?.displayCurrentWeatherDetails(item)
    }
    
    func failedToUpdateWeather(withError error: Error) {
        
    }
}
