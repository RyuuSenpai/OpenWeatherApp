//
//  WeatherAdditionalDetailsView.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 19/03/2023.
//

import UIKit
import Kingfisher

protocol WeatherAdditionalDetailsDataSource {
    var cloudsSate: String { get }
    var cloudsStateDescription: String { get }
    var windSpeed: String { get }
    var humidity: String { get }
    var showIcons: Bool { get }
    var cloudStateIconPath: URL? { get }
}
final class WeatherAdditionalDetailsView: UIView {
    // MARK: - Outlets
    // Icons
    @IBOutlet private weak var cloudsImageView: UIImageView!
    @IBOutlet private weak var windImageView: UIImageView!
    @IBOutlet private weak var humedityImageView: UIImageView!
    // Details Labels
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
        [cloudsImageView, windImageView, humedityImageView].forEach { $0?.isHidden = !details.showIcons }
        cloudsImageView.kf.setImage(with: details.cloudStateIconPath)

    }
}
