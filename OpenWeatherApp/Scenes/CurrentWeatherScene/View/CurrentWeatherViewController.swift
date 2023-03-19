//
//  CurrentWeatherViewController.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 19/03/2023.
//

import Foundation
import UIKit

class CurrentWeatherViewController: UIViewController {
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    var presenter: CurrentWeatherPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension CurrentWeatherViewController: CurrentWeatherControllerProtocol {
    func displayCurrentWeatherDetails(_ details: CurrentWeatherEntity) {

    }
}
