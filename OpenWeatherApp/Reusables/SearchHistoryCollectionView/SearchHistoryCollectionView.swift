//
//  SearchHistoryCollectionView.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 19/03/2023.
//

import Foundation
import UIKit

protocol SearchHistoryCollectionViewDelegate: AnyObject {
    func didSelectItem(atIndex index: Int)
}
typealias SHCollectionViewDelegate = SearchHistoryCollectionViewDelegate
final class SearchHistoryCollectionView: UIView {
    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var historyCollectionView: UICollectionView!
    // MARK: Properties
    private var data = [String]()
    weak var delegate: SHCollectionViewDelegate?
    // MARK: Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadFromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.isHidden = data.isEmpty
    }

    // MARK: ConfigView
    func configView(withData data: [String],
                    delegate: SHCollectionViewDelegate) {
        self.data = data
        self.containerView.isHidden = data.isEmpty
        self.delegate = delegate
        configCollectionView()
    }

    private func configCollectionView() {
        historyCollectionView.delegate = self
        historyCollectionView.dataSource = self
        historyCollectionView.registerCellClass(SearchHistoryCell.self)
        historyCollectionView.contentInset = .init(top: 0,
                                                   left: 16,
                                                   bottom: 0,
                                                   right: 16)
    }

}
// MARK: Conform to UICollectionViewDataSource and Delegate
extension SearchHistoryCollectionView: UICollectionViewDelegate,
                                       UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchHistoryCell",
                                                      for: indexPath) as! SearchHistoryCell
        cell.configCell(withTitle: data[safe: indexPath.row] ?? "")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem(atIndex: indexPath.row)
    }
}

// MARK: Conform to UICollectionViewDelegateFlowLayout
extension SearchHistoryCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        estimatedSizeForItemAt indexPath: IndexPath) -> CGSize {
        return UICollectionViewFlowLayout.automaticSize
    }

}
