//
//  SearchHistoryCollectionViewItem.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 19/03/2023.
//

import Foundation

protocol SearchHistoryCollectionViewItemProtocol {
    var title: String { get }
    var isSelected: Bool  { get set }
}

struct SearchHistoryCollectionViewItem: SearchHistoryCollectionViewItemProtocol {
    let title: String
    var isSelected: Bool
}
