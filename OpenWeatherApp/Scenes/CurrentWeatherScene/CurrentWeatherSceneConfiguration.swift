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
        let interactor = CurrentWeatherInteractor(weatherLoader: WeatherQueryLoader(),
                                                  coreDataManager: CoreDataManager.shared)
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
    func viewWillAppear()
    func didSearhForQuery(query: String)
    func didSelectItem(_ item: SearchHistoryCollectionViewItemProtocol)
    func navigateToForecastScreen()
    func switchUnitOfMeasurement()
}

// Presenter --> Controller
protocol CurrentWeatherControllerProtocol: ViewProtocol {
    func displayWeatherDetails(_ details: CurrentWeatherEntity)
    func updateSearchHistoryList(with data: [SearchHistoryCollectionViewItemProtocol])
    func showSearchHistory(_ show: Bool)
    func setForcastScreenViewVisibility(_ isSlightlyVisible: Bool)
}

// Presenter --> Interactor
protocol CurrentWeatherPresenterInteractorProtocol: InteractorProtocol,
                                                    SearchHistoryCoreDataInteractorProtocol {
    func getUserCurrentLocationWeatherData(with coordinates: CurrentWeatherSceneBuilderInput)
    func didSelectItem(_ item: SearchHistoryCollectionViewItemProtocol)
    func saveCoreDataItems()
    func switchUnitOfMeasurement()
}

// Interactor --> Presenter
protocol CurrentWeatherInteractorOutput: PresenterProtocol {
    func didFetchWeatherData(_ weatherData: DashboardModel.Weather,
                             unitOfMeasurement: APIClient.UnitsOfMeasurement)
    func updateSearchHistoryList(with data: [SearchHistoryCollectionViewItemProtocol])
    
}
// Presenter --> Router
protocol CurrentWeatherRouterProtocol: AnyObject {
    func navigateToForecastScreen()
    func popViewController()
}

