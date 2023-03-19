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
        searchHeaderView.config(searchDelegate: self,
                                historyData: ["1212313", "TEST TEST TEST TEST TEST"],
                                historyCollectionDelegate: self)
    }
    
    // MARK: - IBActions
    @IBAction func popViewhandler(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
