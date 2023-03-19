//
//  ForecastScreenPresenter.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 18/03/2023.
//

import Foundation

final class ForecastScreenPresenter {
    // MARK: - Properites
    private var view: ForecastScreenViewProtocol?
    private var interactor: ForecastScreenPresenterInteractorProtocol?
    private var router: ForecastScreenRouterProtocol?

    // MARK: - Init
    init(view: ForecastScreenViewProtocol?,
         interactor: ForecastScreenPresenterInteractorProtocol?,
         router: ForecastScreenRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

}
// MARK: - Conforming to ForecaseScreenPresenterProtocol
extension ForecastScreenPresenter: ForecaseScreenPresenterProtocol {
    func viewDidLoad() {
        
    }
}
// MARK: - Conforming to ForecastScreenInteractorOutput
extension ForecastScreenPresenter: ForecastScreenInteractorOutput {
    func didSearhForQuery(query: String) {
        interactor?.didSearhForQuery(searchQuery: .init(query: query))
    }
}
