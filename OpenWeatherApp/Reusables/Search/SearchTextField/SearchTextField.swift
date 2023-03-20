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

final class SearchTextField: UIView {
    // MARK: - Outlets
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var clearButton: UIButton!

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
        configClearButtonState()
    }

    private func configTextField() {
        textField.placeholder = "Search"
        textField.addLeadingPadding()
        textField.addTarget(self, action: #selector(searchTextFieldChanged), for: .editingChanged)
    }

    private func configClearButtonState() {
        let shouldDisableButton = textField.text?.isEmpty == true
        clearButton.isEnabled = !shouldDisableButton
        clearButton.alpha = shouldDisableButton ? 0.35 : 1
    }
    // MARK: IBActions
    @IBAction func clearHandler(_ sender: UIButton) {
        self.textField.text = ""
        cancelPreviousSearchQuery()
        notifyDelegate()
        self.textField.becomeFirstResponder()
    }
    // MARK: Config SearchTextField change text Action
    @objc private func searchTextFieldChanged() {
        cancelPreviousSearchQuery()
        // Trigger search query after a delay
        self.perform(#selector(notifyDelegate), with: nil, afterDelay: searchDelay)
    }
    // Cancel any previous search query
    private func cancelPreviousSearchQuery() {
        NSObject.cancelPreviousPerformRequests(withTarget: self,
                                               selector: #selector(notifyDelegate),
                                               object: nil)
    }
    @objc private func notifyDelegate() {
        guard let searchText = textField.text else { return }
        searchDelegate?.search(for: searchText)
        configClearButtonState()
    }
}
