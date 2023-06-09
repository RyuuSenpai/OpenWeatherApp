//
//  DashboardInteractor.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 14/03/2023.
//

import Foundation
import CoreLocation

final class DashboardInteractor {
    // MARK: - Properites
    var presenter: DashboardInteractorOutput?
    private let weatherLoader: WeatherLoaderProtocol
    private let locationManager: LocationManagerDelegate?
    // Passing LocationManagerDelegate to make it easier for us to Apply UnitTest, and 
    init(weatherLoader: WeatherLoaderProtocol,
         locationManager: LocationManagerDelegate? = nil) {
        self.weatherLoader = weatherLoader
        self.locationManager = locationManager
        self.locationManager?.authorizationDelegate = self
    }
}
// MARK: Conforming to DashboardPresenterInteractorProtocol
extension DashboardInteractor: DashboardPresenterInteractorProtocol {
    // MARK: - Get User Location
    func getUserCurrentLocation() {
        locationManager?.getCurrentLocation(completion: { [weak self] userLocation in
            guard let self else { return }
            self.presenter?.loadaUserCurrentWeather(byLocation: userLocation?.coordinate.latitude ?? 30.0,
                                                    userLocation?.coordinate.longitude ?? 30.0)
        })
    }
    // MARK: API Calls
    func fetchWeatherData(for latitude: Double,
                          _ longitude: Double) {
        weatherLoader.loadCurrentWeatherData(with: latitude, longitude) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let weatherData):
                // handle success case
                self.presenter?.didFetchCurrentWeatherData(weatherData)
            case .failure(let error):
                // handle error case
                self.presenter?.failedToUpdateWeather(withError: error)
            }
        }
    }
}
// MARK: Conform to LocationAuthorizationDelegate
extension DashboardInteractor: LocationAuthorizationDelegate {
    func authorizationStatusChanged(status: LocationAuthorizationStatus) {
        self.presenter?.userDidGiveLocationAccessPermission(status == .authorized)
    }
}
