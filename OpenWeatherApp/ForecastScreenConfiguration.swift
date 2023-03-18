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
        let interactor = ForecastScreenInteractor()
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
}

// Presenter --> Controller
protocol ForecastScreenViewProtocol: AnyObject {
}


// Presenter --> Interactor
protocol ForecastScreenPresenterInteractorProtocol: AnyObject {
}

// Interactor --> Presenter
protocol ForecastScreenInteractorOutput: AnyObject {
}
// Presenter --> Router
protocol ForecastScreenRouterProtocol: AnyObject {
    func navigateToWeatherDetailsScreen()
}
