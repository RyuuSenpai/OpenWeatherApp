//
//  CurrentWeatherViewController.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 19/03/2023.
//

import Foundation
import UIKit

class CurrentWeatherViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet private weak var searchHeaderView: SearchHeaderView!
    @IBOutlet private weak var cityNameLabel: UILabel!
    // Current Weather Details
    @IBOutlet weak var weatherDetailsView: WeatherAdditionalDetailsView!
    // Temp Data
    @IBOutlet private weak var currentTempLabel: UILabel!
    @IBOutlet private weak var highTempLabel: UILabel!
    @IBOutlet private weak var lowTempLabel: UILabel!

    // MARK: Properties
    var presenter: CurrentWeatherPresenterProtocol?
    var items = [WeatherDetailsCellDataSource]()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchHeaderView.config(searchDelegate: self,
                                historyCollectionDelegate: self)
        hideKeyboardWhenTappedAround()
        configView()
        presenter?.viewDidLoad()
    }

    // MARK: Cofigurations
    func configView() {

    }
    // MARK: - IBActions
    @IBAction func popViewhandler(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CurrentWeatherViewController: CurrentWeatherControllerProtocol {
    func displayWeatherDetails(_ details: CurrentWeatherEntity) {
        cityNameLabel.text = details.cityName
        currentTempLabel.text = details.weatherBaseData.currentTemp
        highTempLabel.text = details.highestTemp
        lowTempLabel.text = details.lowestTemp
        weatherDetailsView.configView(with: details.weatherBaseData)
    }
    func updateSearchHistoryList(with data: [SearchHistoryCollectionViewItemProtocol]) {
        self.searchHeaderView.setHistoryListData(data)
    }
}
// MARK: - Conforming to SearchTextFieldDelegate
extension CurrentWeatherViewController: SearchTextFieldDelegate {
    func search(for query: String) {
        presenter?.didSearhForQuery(query: query)
    }
}
// MARK: - Conforming to SHCollectionViewDelegate
extension CurrentWeatherViewController: SHCollectionViewDelegate {
    func didSelectItem(_ item: SearchHistoryCollectionViewItemProtocol) {
        presenter?.didSelectItem(item)
    }
}
