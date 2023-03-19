//
//  WeatherDetailsCell.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 19/03/2023.
//

import UIKit

class WeatherDetailsCell: UITableViewCell {
    // MARK: Outlets
    // Details
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var weatherStateImageView: UIImageView!
    @IBOutlet private weak var weatherStateLabel: UILabel!
    // Temp Data
    @IBOutlet private weak var currentTempLabel: UILabel!
    @IBOutlet private weak var highTempLabel: UILabel!
    @IBOutlet private weak var lowTempLabel: UILabel!
    // Collapsing ImageView
    @IBOutlet weak var collapseImageView: UIImageView!
    // WeatherDetails ContainerView
    @IBOutlet weak var weatherDetailsViewContainer: WeatherAdditionalDetailsView!

    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configCell(withItem item: WeatherDetailsCellDataSource?) {
        guard let item = item else { return }
        dateLabel.text = item.date
        weatherStateImageView.kf.setImage(with: item.weatherDetails.cloudStateIconPath)
        weatherStateLabel.text = item.weatherDetails.cloudsStateDescription
        currentTempLabel.text = item.currentTemp
        highTempLabel.text = item.highestTemp
        lowTempLabel.text = item.lowestTemp
        // ConfigWeatherDetailsWithData
        weatherDetailsViewContainer.configView(with: item.weatherDetails)
        weatherDetailsViewContainer.isHidden = !item.isExpanded
        collapseImageView.transform = !item.isExpanded ? .identity : CGAffineTransform(rotationAngle: CGFloat.pi)

    }
}
