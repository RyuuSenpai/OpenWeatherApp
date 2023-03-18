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

// Controller --> Presenter
protocol DashboardPresenterProtocol: AnyObject {
    func viewDidLoad()
}

// Presenter --> Controller
protocol DashboardControllerProtocol: AnyObject {
    func displayCurrentWeatherDetails(_ details: CurrentWeatherItemDetails)
}

// Presenter --> Interactor
protocol DashboardPresenterInteractorProtocol: AnyObject {
    func getUserCurrentLocation()
    func fetchWeatherData(for latitude: Double,
                          _ longitude: Double)
}

// Interactor --> Presenter
protocol DashboardInteractorOutput: AnyObject {
    func didFetchCurrentWeatherData(_ weatherData: DashboardEntity.Weather)
    func failedToUpdateWeather(withError error: Error)
    func loadaUserCurrentWeather(byLocation latitude: Double,
                                 _ longitude: Double)
}
// Presenter --> Router
protocol DashboardRouterProtocol: AnyObject {
    func navigateToForecastScreen()
    func navigateToCurrentWeatherScreen()
}
// Current Weather Item
struct CurrentWeatherItemDetails {
    private let temp: Double
    let cloudsSate: String
    let cloudsStateDescription: String
    private let cloudStateIconName: String
    private let windSpeedValue: Double
    private let humidityValue: Int

    var currentTemp: String {
        Int(temp.rounded()).stringValue
    }
    var cloudStateIconPath: String {
        cloudStateIconName.imageUrlPath
    }
    var windSpeed: String {
        windSpeedValue.stringValue
    }
    var humidity: String {
        humidityValue.stringValue + "%"
    }
    init(currentTemp: Double,
         cloudsSate: String,
         cloudsStateDescription: String,
         cloudStateIconName: String,
         windSpeedValue: Double,
         humidityValue: Int) {
        self.temp = currentTemp
        self.cloudsSate = cloudsSate
        self.cloudsStateDescription = cloudsStateDescription
        self.cloudStateIconName = cloudStateIconName
        self.windSpeedValue = windSpeedValue
        self.humidityValue = humidityValue
    }
}
