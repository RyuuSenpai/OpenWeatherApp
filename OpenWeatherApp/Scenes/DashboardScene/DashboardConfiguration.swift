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
    func navigateToForecastScreen()
    func navigateToCurrentWeatherScreen()
}

// Presenter --> Controller
protocol DashboardControllerProtocol: AnyObject {
    func displayCurrentWeatherDetails(_ details: DashboardEntity)
}

// Presenter --> Interactor
protocol DashboardPresenterInteractorProtocol: AnyObject {
    func getUserCurrentLocation()
    func fetchWeatherData(for latitude: Double,
                          _ longitude: Double)
}

// Interactor --> Presenter
protocol DashboardInteractorOutput: AnyObject {
    func didFetchCurrentWeatherData(_ weatherData: DashboardModel.Weather)
    func failedToUpdateWeather(withError error: Error)
    func loadaUserCurrentWeather(byLocation latitude: Double,
                                 _ longitude: Double)
}
// Presenter --> Router
protocol DashboardRouterProtocol: AnyObject {
    func navigateToForecastScreen()
    func navigateToCurrentWeatherScreen(data: CurrentWeatherSceneBuilderInput)
}
