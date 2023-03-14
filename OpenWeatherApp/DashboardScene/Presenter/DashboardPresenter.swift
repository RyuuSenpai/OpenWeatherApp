//
//  DashboardPresenter.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 14/03/2023.
//

import Foundation

final class DashboardPresenter {
    // MARK: - Properites
    weak private var view: DashboardControllerProtocol?
    weak private var interactor: DashboardPresenterInteractorProtocol?
    weak private var router: DashboardRouterProtocol?
    // MARK: - Init
    init(view: DashboardControllerProtocol?,
         interactor: DashboardPresenterInteractorProtocol?,
         router: DashboardRouterProtocol?) {
        self.view = view
        self.interactor = interactor
    }
}
// MARK: - Conforming to DashboardPresenterProtocol
extension DashboardPresenter: DashboardPresenterProtocol {
    func viewDidLoad() {
    }
}
// MARK: - Conforming to DashboardInteractorOutput
extension DashboardPresenter: DashboardInteractorOutput {
    func displayWeatherData(_ weatherData: DashboardEntity.Weather) {
    }
    
    func failedToUpdateWeather(withError error: Error) {
        
    }
}
