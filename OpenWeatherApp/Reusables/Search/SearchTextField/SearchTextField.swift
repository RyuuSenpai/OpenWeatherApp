//
//  SearchView.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 18/03/2023.
//

import Foundation
import UIKit

protocol SearchTextFieldDelegate: AnyObject {
    func search(for query: String)
}

final class SearchTextField: UITextField {
    // MARK: - Outlets
    @IBOutlet weak var textField: UITextField!

    // MARK: Properties
    weak var searchDelegate: SearchTextFieldDelegate?

    // MARK: Constants
    private let searchDelay: TimeInterval = 0.7

    // MARK: Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadFromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }
    // MARK: ConfigView
    func configView(searchDelegate: SearchTextFieldDelegate) {
        self.searchDelegate = searchDelegate
        configTextField()

    }

    private func configTextField() {
        textField.placeholder = "Search"
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(searchTextFieldChanged), for: .editingChanged)
    }

    @objc private func searchTextFieldChanged() {
        // Cancel any previous search query
        NSObject.cancelPreviousPerformRequests(withTarget: self,
                                               selector: #selector(notifyDelegate),
                                               object: nil)
        // Trigger search query after a delay
        self.perform(#selector(notifyDelegate), with: nil, afterDelay: searchDelay)
    }

    @objc private func notifyDelegate() {
        guard let searchText = textField.text, !searchText.isEmpty else { return }
        searchDelegate?.search(for: searchText)
    }
}
