//
//  SearchHistoryCell.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 19/03/2023.
//

import UIKit

final class SearchHistoryCell: UICollectionViewCell {
    // MARK: Outlets
    @IBOutlet private weak var containerCardView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    // MARK: ConfigCell 
    func configCell(withData data: SearchHistoryCollectionViewItemProtocol?) {
        guard let data = data else { return }
        self.titleLabel.text = data.title
        self.containerCardView.borderColor = data.isSelected ? .black : .clear
        self.containerCardView.borderWidth = data.isSelected ? 1.5 : .zero
    }
}
