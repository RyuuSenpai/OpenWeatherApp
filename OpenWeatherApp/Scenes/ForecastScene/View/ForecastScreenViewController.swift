//
//  ForecastScreenViewController.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 18/03/2023.
//

import UIKit

class ForecastScreenViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet private weak var searchHeaderView: SearchHeaderView!
    @IBOutlet private weak var searchResultTableView: UITableView!
    @IBOutlet private weak var cityNameLabel: UILabel!
    // MARK: Properties
    var presenter: ForecaseScreenPresenterProtocol?
    var city: ForecastScreenEntity.City?
    var items = [ForecastScreenEntity.Item]()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchHeaderView.config(searchDelegate: self,
                                historyCollectionDelegate: self)
        hideKeyboardWhenTappedAround()
        configTableView()
        presenter?.viewDidLoad()
    }

    // MARK: Cofigurations
    func configTableView() {
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        searchResultTableView.register(UINib(nibName: "WeatherDetailsCell",
                                             bundle: .none),
                                       forCellReuseIdentifier: "WeatherDetailsCell")
    }
    // MARK: - IBActions
    @IBAction func popViewhandler(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
// MARK: - Conforming to ForecastScreenViewProtocol
extension ForecastScreenViewController: ForecastScreenViewProtocol {
    func updateSearchHistoryList(with data: [SearchHistoryCollectionViewItemProtocol]) {
        self.searchHeaderView.setHistoryListData(data)
    }

    func displayForecastList(with cityData: ForecastScreenEntity.City?) {
        self.city = cityData
        self.items = city?.items ?? []
        self.cityNameLabel.text = cityData?.fullName ?? ""
        self.searchResultTableView?.reloadData()
    }
}
// MARK: Conform to TableView Delegate and DataSource
extension ForecastScreenViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherDetailsCell", for: indexPath) as! WeatherDetailsCell
        cell.configCell(withItem: items[safe: indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.items[safe: indexPath.row]?.isExpanded.toggle()
        // Reload only the selected row
        searchResultTableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
// MARK: - Conforming to SearchTextFieldDelegate
extension ForecastScreenViewController: SearchTextFieldDelegate {
    func search(for query: String) {
        presenter?.didSearhForQuery(query: query)
    }
}
// MARK: - Conforming to SHCollectionViewDelegate
extension ForecastScreenViewController: SHCollectionViewDelegate {
    func didSelectItem(_ item: SearchHistoryCollectionViewItemProtocol) {
        presenter?.didSelectItem(item)
    }
}
