//
//  CurrentWeatherSceneConfiguration.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 19/03/2023.
//

import Foundation
import UIKit

protocol CurrentWeatherSceneBuilderInput {
    var lat: String { get }
    var lon: String { get }
}
struct CurrentWeatherSceneBuilderInputItem: CurrentWeatherSceneBuilderInput {
    let lat: String
    let lon: String
}
// MARK: - Builder
final class CurrentWeatherSceneBuilder {
    static func build(with data: CurrentWeatherSceneBuilderInput) -> UIViewController {
        let view = CurrentWeatherViewController()
        let interactor = CurrentWeatherInteractor(weatherLoader: WeatherQueryLoader())
        let router = CurrentWeatherRouter(viewController: view)
        let presenter = CurrentWeatherPresenter(view: view,
                                                interactor: interactor,
                                                router: router,
                                                userCurrentCoordinates: data)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
// MARK: - Protocols
// Controller --> Presenter
protocol CurrentWeatherPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didSearhForQuery(query: String)
    func didSelectItem(_ item: SearchHistoryCollectionViewItemProtocol)
}

// Presenter --> Controller
protocol CurrentWeatherControllerProtocol: AnyObject {
    func displayWeatherDetails(_ details: CurrentWeatherEntity)
}

// Presenter --> Interactor
protocol CurrentWeatherPresenterInteractorProtocol: AnyObject {
    func getUserCurrentLocation(with coordinates: CurrentWeatherSceneBuilderInput)
    func fetchWeatherData(for latitude: Double,
                          _ longitude: Double)
}

// Interactor --> Presenter
protocol CurrentWeatherInteractorOutput: AnyObject {
    func didFetchWeatherData(_ weatherData: DashboardModel.Weather)
    func failedToUpdateWeather(withError error: Error)

}
// Presenter --> Router
protocol CurrentWeatherRouterProtocol: AnyObject {
    func navigateToForecastScreen()
    func popViewController()
}

