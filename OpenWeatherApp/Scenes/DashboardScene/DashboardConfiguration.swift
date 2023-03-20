//
//  DashboardBuilder.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 14/03/2023.
//

import Foundation
import UIKit

// MARK: - Builder
final class DashboardModuleBuilder {
    
    static func build() -> UIViewController {
        let view = DashboardViewController()
        let interactor = DashboardInteractor(weatherLoader: WeatherLoader(),
                                             locationManager: LocationManager.shared)
        let router = DashboardRouter(viewController: view)
        let presenter = DashboardPresenter(view: view,
                                           interactor: interactor,
                                           router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}

// MARK: - Protocols
// Controller --> Presenter
protocol DashboardPresenterProtocol: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func navigateToForecastScreen()
    func navigateToCurrentWeatherScreen()
    func navigateToAppSettings()
}

// Presenter --> Controller
protocol DashboardControllerProtocol: ViewProtocol {
    func displayCurrentWeatherDetails(_ details: DashboardEntity)
    func showAlert(title: String,
                   message: String,
                   actionTitle: String,
                   completionHandler: (() -> Void)?)
}

// Presenter --> Interactor
protocol DashboardPresenterInteractorProtocol: AnyObject {
    func getUserCurrentLocation()
    func fetchWeatherData(for latitude: Double,
                          _ longitude: Double)
}

// Interactor --> Presenter
protocol DashboardInteractorOutput: PresenterProtocol {
    func didFetchCurrentWeatherData(_ weatherData: DashboardModel.Weather)
    func failedToUpdateWeather(withError error: Error)
    func loadaUserCurrentWeather(byLocation latitude: Double,
                                 _ longitude: Double)
    func userDidGiveLocationAccessPermission(_ state: Bool)
}
// Presenter --> Router
protocol DashboardRouterProtocol: AnyObject {
    func navigateToForecastScreen()
    func navigateToCurrentWeatherScreen(data: CurrentWeatherSceneBuilderInput)
    func navigateToAppSettings()
}
