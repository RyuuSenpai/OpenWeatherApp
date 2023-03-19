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

    weak var view: CurrentWeatherControllerProtocol?

    init(view: CurrentWeatherControllerProtocol,
         interactor: CurrentWeatherPresenterInteractorProtocol,
         router: CurrentWeatherRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension CurrentWeatherPresenter: CurrentWeatherPresenterProtocol {
    func viewDidLoad() {

    }
    
    func didSearhForQuery(query: String) {

    }

    func didSelectItem(_ item: SearchHistoryCollectionViewItemProtocol) {
        
    }
}

extension CurrentWeatherPresenter: CurrentWeatherInteractorOutput {
}
