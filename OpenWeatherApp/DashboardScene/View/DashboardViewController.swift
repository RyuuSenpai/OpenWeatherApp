//
//  DashboardViewController.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 14/03/2023.
//

import UIKit

final class DashboardViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var forcastScreenView: UIView!
    @IBOutlet private weak var currentWeatherView: UIView!
    // Current Weather Temp
    @IBOutlet private weak var weatherTempLabel: UILabel!
    // Current Weather Details
    @IBOutlet private weak var weatherCloudsStateLabel: UILabel!
    @IBOutlet private weak var weatherCloudsDescriptionLabel: UILabel!
    @IBOutlet private weak var windSpeedlLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!

    // MARK: - Properites
    var presenter: DashboardPresenterProtocol?
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        // Call Presetner ViewDidLoad that init the API calls and getting UserLocation
        presenter?.viewDidLoad()
    }

    // MARK: - Config
    func configView() {
        forcastScreenView.addShadow()
        currentWeatherView.addShadow()
        addActionsForViews()
    }
    func addActionsForViews() {
        forcastScreenView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openForecastScreen)))
    }
    // MARK: Actions
    @objc func openForecastScreen() {
        presenter?.navigateToForecastScreen()
    }

}
// MARK: - Conforming to DashboardControllerProtocol
extension DashboardViewController: DashboardControllerProtocol {
    func displayCurrentWeatherDetails(_ details: CurrentWeatherItemDetails) {
        weatherTempLabel.text = details.currentTemp
        weatherCloudsStateLabel.text = details.cloudsSate
        weatherCloudsDescriptionLabel.text = details.cloudsStateDescription
        windSpeedlLabel.text = details.windSpeed
        humidityLabel.text = details.humidity
    }
}
