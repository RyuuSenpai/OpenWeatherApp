//
//  ForecastScreenInteractor.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 18/03/2023.
//

import Foundation

final class ForecastScreenInteractor {
    // MARK: - Properites
    var presenter: ForecastScreenInteractorOutput?
    
}

// MARK: - Conforming to ForecastScreenPresenterInteractorProtocol
extension ForecastScreenInteractor: ForecastScreenPresenterInteractorProtocol {
    func didSearhForQuery(searchQuery: SearchQuery) {
        debugPrint("query: \(searchQuery.query), QueryType: \(searchQuery.inputType)")
    }
}

