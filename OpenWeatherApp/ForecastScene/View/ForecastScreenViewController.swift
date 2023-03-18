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

    // MARK: Properties
    var presenter: ForecaseScreenPresenterProtocol?
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchHeaderView.config(searchDelegate: self,
                                historyData: ["1212313", "TEST TEST TEST TEST TEST"],
                                historyCollectionDelegate: self)
    }
}
// MARK: - Conforming to ForecastScreenViewProtocol
extension ForecastScreenViewController: ForecastScreenViewProtocol {

}
// MARK: - Conforming to SearchTextFieldDelegate
extension ForecastScreenViewController: SearchTextFieldDelegate {
    func search(for query: String) {
        debugPrint("Query: \(query)")
    }
}
// MARK: - Conforming to SHCollectionViewDelegate
extension ForecastScreenViewController: SHCollectionViewDelegate {
    func didSelectItem(atIndex index: Int) {
        debugPrint("didSelectItem: \(index)")
    }
}
