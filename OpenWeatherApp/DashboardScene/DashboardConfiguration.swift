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
        let interactor = DashboardInteractor(weatherLoader: WeatherLoader())
        let router = DashboardRouter(viewController: view)
        let presenter = DashboardPresenter(view: view,
                                           interactor: interactor,
                                           router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}

// Controller --> Presenter
protocol DashboardPresenterProtocol: AnyObject {
    func viewDidLoad()
}

// Presenter --> Controller
protocol DashboardControllerProtocol: AnyObject {

}

// Presenter --> Interactor
protocol DashboardPresenterInteractorProtocol: AnyObject {
}

// Interactor --> Presenter
protocol DashboardInteractorOutput: AnyObject {
    func displayWeatherData(_ weatherData: DashboardEntity.Weather)
    func failedToUpdateWeather(withError error: Error)
}
// Presenter --> Router
protocol DashboardRouterProtocol: AnyObject {
    func navigateToForecastScreen()
    func navigateToCurrentWeatherScreen()
}