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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: "DashboardViewController") as? DashboardViewController else {
            return UIViewController()
        }
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
protocol DashboardPresenterProtocol: DashboardRouterProtocol {
    func viewDidLoad()
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
    func navigateToCurrentWeatherScreen()
}
