//
//  CurrentWeatherPresenter.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 19/03/2023.
//

import Foundation

class CurrentWeatherPresenter {
    private var interactor: CurrentWeatherPresenterInteractorProtocol?
    private var router: CurrentWeatherRouterProtocol?

    private var view: CurrentWeatherControllerProtocol?
    private var userCurrentCoordinates: CurrentWeatherSceneBuilderInput
    private var didSearchOnce = false
    // MARK: - Init
    init(view: CurrentWeatherControllerProtocol,
         interactor: CurrentWeatherPresenterInteractorProtocol,
         router: CurrentWeatherRouterProtocol,
         userCurrentCoordinates: CurrentWeatherSceneBuilderInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.userCurrentCoordinates = userCurrentCoordinates
    }
}

extension CurrentWeatherPresenter: CurrentWeatherPresenterProtocol {
    func viewDidLoad() {
        view?.showSearchHistory(false)
        interactor?.fetchSearchHistory()
        interactor?.getUserCurrentLocationWeatherData(with: userCurrentCoordinates)
    }

    func switchUnitOfMeasurement() {
        interactor?.switchUnitOfMeasurement()
    }
    func didSearhForQuery(query: String) {
        guard !query.isEmpty else { return }
        self.didSearchOnce = true
        interactor?.didSearhForQuery(searchQuery: .init(query: query))
        self.view?.showSearchHistory(true)
        self.view?.setForcastScreenViewVisibility(false)
    }

    func didSelectItem(_ item: SearchHistoryCollectionViewItemProtocol) {
        interactor?.didSelectItem(item)
    }

    func navigateToForecastScreen() {
        guard didSearchOnce else {
            let message = "Must search for a location before being able to navigating to Forecast screen"
            showAlert(withTitle: "Sorry", message: message)
            return
        }
        self.interactor?.saveCoreDataItems()
        self.router?.navigateToForecastScreen()
    }
}

extension CurrentWeatherPresenter: CurrentWeatherInteractorOutput {
    func showAlert(withTitle title: String, message: String) {
        view?.showAlert(withTitle: title, message: message)
    }

    func didFetchWeatherData(_ weatherData: DashboardModel.Weather,
                             unitOfMeasurement: APIClient.UnitsOfMeasurement) {
        let tempMax = weatherData.main?.tempMax?.roundNumber ?? ""
        let tempMin = weatherData.main?.tempMin?.roundNumber ?? ""
        let detailsItem = DashboardEntity(weatherData,
                                          unitOfMeasurement: unitOfMeasurement)
        view?.displayWeatherDetails(.init(weatherBaseData: detailsItem,
                                          highestTemp: tempMax,
                                          lowestTemp: tempMin,
                                          cityName: weatherData.name ?? ""))
    }
    func updateSearchHistoryList(with data: [SearchHistoryCollectionViewItemProtocol]) {
        self.view?.updateSearchHistoryList(with: data)
    }
    func failedToUpdateWeather(withError error: Error) {
        showAlert(withTitle: "Error", message: "Invalid Search")
    }
}
