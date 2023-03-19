//
//  WeatherAdditionalDetailsView.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 19/03/2023.
//

import UIKit

protocol WeatherAdditionalDetailsDataSource {
    var cloudsSate: String { get }
    var cloudsStateDescription: String { get }
    var windSpeed: String { get }
    var humidity: String { get }
}
final class WeatherAdditionalDetailsView: UIView {
    // MARK: - Outlets
    @IBOutlet private weak var weatherCloudsStateLabel: UILabel!
    @IBOutlet private weak var weatherCloudsDescriptionLabel: UILabel!
    @IBOutlet private weak var windSpeedlLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!

    // MARK: Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadFromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }
    // MARK: Config
    func configView(with details: WeatherAdditionalDetailsDataSource) {
        weatherCloudsStateLabel.text = details.cloudsSate
        weatherCloudsDescriptionLabel.text = details.cloudsStateDescription
        windSpeedlLabel.text = details.windSpeed
        humidityLabel.text = details.humidity
    }
}
