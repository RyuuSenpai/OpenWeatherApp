//
//  ForecastScreenRouter.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 18/03/2023.
//

import Foundation
import UIKit

final class ForecastScreenRouter {
    weak private var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}
// MARK: - Conforming to ForecastScreenRouterProtocol
extension ForecastScreenRouter: ForecastScreenRouterProtocol {
    func navigateToWeatherDetailsScreen() {

    }
}
