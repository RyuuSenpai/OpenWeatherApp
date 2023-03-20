//
//  ForecastScreenConfiguration.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 18/03/2023.
//

import Foundation
import UIKit
// MARK: - Builder
final class ForecastScreenBuilder {
    static func build() -> UIViewController {
        let view = ForecastScreenViewController()
        let interactor = ForecastScreenInteractor(forecastLoader: ForecastLoader())
        let router = ForecastScreenRouter(viewController: view)
        let presenter = ForecastScreenPresenter(view: view,
                                                interactor: interactor,
                                                router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}

// Controller --> Presenter
protocol ForecaseScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didSearhForQuery(query: String)
    func didSelectItem(_ item: SearchHistoryCollectionViewItemProtocol)
    func refreshData()
}

// Presenter --> Controller
protocol ForecastScreenViewProtocol: AnyObject {
    func displayForecastList(with cityData: ForecastScreenEntity.City?)
    func updateSearchHistoryList(with data: [SearchHistoryCollectionViewItemProtocol])
    func beginRefreshing()
    func endRefreshing()
}


// Presenter --> Interactor
protocol ForecastScreenPresenterInteractorProtocol: SearchHistoryCoreDataInteractorProtocol {
    func didSearhForQuery(searchQuery: SearchQuery)
    func didSelectItem(_ item: SearchHistoryCollectionViewItemProtocol)
    func refreshData()
}

// Interactor --> Presenter
protocol ForecastScreenInteractorOutput: AnyObject {
    func didFetchForecast(data: ForecastModel.Forecast)
    func updateSearchHistoryList(with data: [SearchHistoryCollectionViewItemProtocol])
}
// Presenter --> Router
protocol ForecastScreenRouterProtocol: AnyObject {
    func navigateToWeatherDetailsScreen()
}
