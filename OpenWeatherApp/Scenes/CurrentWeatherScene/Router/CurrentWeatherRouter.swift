//
//  CurrentWeatherRouter.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 19/03/2023.
//

import Foundation
import UIKit

class CurrentWeatherRouter {
    weak private var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension CurrentWeatherRouter: CurrentWeatherRouterProtocol {
    func navigateToForecastScreen() {
        let vc = ForecastScreenBuilder.build()
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }

    func popViewController() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
