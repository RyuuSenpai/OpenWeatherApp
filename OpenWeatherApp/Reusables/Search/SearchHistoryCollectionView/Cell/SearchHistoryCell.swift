//
//  SearchHistoryCell.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 19/03/2023.
//

import UIKit

final class SearchHistoryCell: UICollectionViewCell {
    // MARK: Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    // MARK: ConfigCell 
    func configCell(withTitle title: String) {
        self.titleLabel.text = title
    }
}
