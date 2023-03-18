//
//  ForecastScreenViewController.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 18/03/2023.
//

import UIKit

class ForecastScreenViewController: UIViewController {

    // MARK: Properties
    var presenter: ForecaseScreenPresenterProtocol?
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
// MARK: - Conforming to ForecastScreenViewProtocol
extension ForecastScreenViewController: ForecastScreenViewProtocol {

}
