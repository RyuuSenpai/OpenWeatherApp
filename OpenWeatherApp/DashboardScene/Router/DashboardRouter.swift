//
//  DashboardRouter.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 14/03/2023.
//

import Foundation
import UIKit

final class DashboardRouter {
    weak private var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension DashboardRouter: DashboardRouterProtocol {
    func navigateToForecastScreen() {
    }

    func navigateToCurrentWeatherScreen() {
    }


}
