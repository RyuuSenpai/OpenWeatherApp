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
    
    func didSearhForQuery(query: String) {
        guard !query.isEmpty else { return }
        interactor?.didSearhForQuery(searchQuery: .init(query: query))
        self.view?.showSearchHistory(true)
    }

    func didSelectItem(_ item: SearchHistoryCollectionViewItemProtocol) {
        interactor?.didSelectItem(item)
    }

    func navigateToForecastScreen() {
        CoreDataManager.shared.saveContext()
        self.router?.navigateToForecastScreen()
    }
}

extension CurrentWeatherPresenter: CurrentWeatherInteractorOutput {
    func didFetchWeatherData(_ weatherData: DashboardModel.Weather) {
        let tempMax = weatherData.main?.tempMax?.roundNumber ?? ""
        let tempMin = weatherData.main?.tempMin?.roundNumber ?? ""
        let detailsItem = DashboardEntity(weatherData)
        view?.displayWeatherDetails(.init(weatherBaseData: detailsItem,
                                          highestTemp: tempMax,
                                          lowestTemp: tempMin,
                                          cityName: weatherData.name ?? ""))
    }
    func updateSearchHistoryList(with data: [SearchHistoryCollectionViewItemProtocol]) {
        self.view?.updateSearchHistoryList(with: data)
    }
    func failedToUpdateWeather(withError error: Error) {

    }
}
