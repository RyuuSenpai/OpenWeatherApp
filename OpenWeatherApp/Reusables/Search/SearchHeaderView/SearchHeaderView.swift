//
//  SearchHeaderView.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 19/03/2023.
//

import Foundation
import UIKit

final class SearchHeaderView: UIView {
    // MARK: - Outlets
    @IBOutlet private weak var searchTextFieldContainer: SearchTextField!
    @IBOutlet private weak var searchHistoryContainer: SearchHistoryCollectionView!

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
    func config(searchDelegate: SearchTextFieldDelegate,
                historyData: [SearchHistoryCollectionViewItemProtocol] = [],
                historyCollectionDelegate collectionDelegate: SHCollectionViewDelegate) {
        searchTextFieldContainer.configView(searchDelegate: searchDelegate)
        searchHistoryContainer.configView(withData: historyData,
                                          delegate: collectionDelegate)
    }
    func setHistoryListData(_ data: [SearchHistoryCollectionViewItemProtocol]) {
        searchHistoryContainer.setData(data)
    }

    func hideSearchHistoryContainer(_ hide: Bool) {
        self.searchHistoryContainer.isHidden = hide
    }
}
