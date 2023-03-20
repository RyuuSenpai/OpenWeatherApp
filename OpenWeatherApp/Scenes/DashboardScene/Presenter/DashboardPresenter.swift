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
    var locationPermissionIsGiven = false
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
    func viewDidLoad() {
        interactor?.getUserCurrentLocation()
    }

    func viewWillAppear() {
        guard locationPermissionIsGiven else { return }
        requestLocationPermissionAlert()
    }
    // MARK: Routing
    func navigateToForecastScreen() {
        guard validateLocationPermission() else { return }
        router?.navigateToForecastScreen()
    }

    func navigateToAppSettings() {
        router?.navigateToAppSettings()
    }

    func navigateToCurrentWeatherScreen() {
        guard validateLocationPermission() else { return }
        let lat = userLocation?.latitude.stringValue ?? ""
        let lon = userLocation?.longitude.stringValue ?? ""
        let currentLocationCoordinates = CurrentWeatherSceneBuilderInputItem(lat: lat,
                                                                             lon: lon)
        router?.navigateToCurrentWeatherScreen(data: currentLocationCoordinates)
    }
}
// MARK: - Conforming to DashboardInteractorOutput
extension DashboardPresenter: DashboardInteractorOutput {
    func showAlert(withTitle title: String, message: String) {
        self.view?.showAlert(withTitle: title, message: message)
    }

    // MARK: UserLocationUpdates
    func loadaUserCurrentWeather(byLocation latitude: Double, _ longitude: Double) {
        self.userLocation = (latitude, longitude)
        self.interactor?.fetchWeatherData(for: latitude, longitude)
    }
    // MARK: API Delegates
    func didFetchCurrentWeatherData(_ weatherData: DashboardModel.Weather) {
        let item = DashboardEntity(weatherData)
        view?.displayCurrentWeatherDetails(item)
    }

    func userDidGiveLocationAccessPermission(_ state: Bool) {
        locationPermissionIsGiven = state
    }

    private func requestLocationPermissionAlert() {
        guard !locationPermissionIsGiven else { return }
        view?.showAlert(title: "Sorry",
                        message: "You need to enable location access in settings to use this feature.",
                        actionTitle: "Take me to settings", completionHandler: { [weak self] in
            guard let self else { return }
            self.router?.navigateToAppSettings()
        })
    }
    func failedToUpdateWeather(withError error: Error) {
        
    }

    private func validateLocationPermission() -> Bool {
        guard locationPermissionIsGiven else {
            requestLocationPermissionAlert()
            return false
        }
        return true
    }
}
