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
    func navigateToCurrentWeatherScreen(data: CurrentWeatherSceneBuilderInput) {
        let vc = CurrentWeatherSceneBuilder.build(with: data)
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }

    func navigateToForecastScreen() {
        let vc = ForecastScreenBuilder.build()
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
