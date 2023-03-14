//
//  DashboardViewController.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 14/03/2023.
//

import UIKit

final class DashboardViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var forcastScreenView: UIView!
    @IBOutlet weak var currentWeatherView: UIView!
    // MARK: - Properites
    weak var presenter: DashboardPresenterProtocol?
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    // MARK: - Config
    func configView() {
        forcastScreenView.addShadow()
        currentWeatherView.addShadow()
    }
}
// MARK: - Conforming to DashboardControllerProtocol
extension DashboardViewController: DashboardControllerProtocol {
}
