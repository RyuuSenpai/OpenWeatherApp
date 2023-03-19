//
//  CurrentWeatherPresenter.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 19/03/2023.
//

import Foundation

class CurrentWeatherPresenter {
    private let interactor: CurrentWeatherPresenterInteractorProtocol
    private let router: CurrentWeatherRouterProtocol

    private var view: CurrentWeatherControllerProtocol?
    private let userCurrentCoordinates: CurrentWeatherSceneBuilderInput
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
        interactor.getUserCurrentLocation(with: userCurrentCoordinates)
    }
    
    func didSearhForQuery(query: String) {

    }

    func didSelectItem(_ item: SearchHistoryCollectionViewItemProtocol) {
        
    }
}

extension CurrentWeatherPresenter: CurrentWeatherInteractorOutput {
    func didFetchWeatherData(_ weatherData: DashboardModel.Weather) {
        let detailsItem = DashboardEntity(weatherData)
        view?.displayWeatherDetails(detailsItem)
    }

    func failedToUpdateWeather(withError error: Error) {

    }
}
