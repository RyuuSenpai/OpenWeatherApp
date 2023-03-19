//
//  SearchHistoryCollectionView.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 19/03/2023.
//

import Foundation
import UIKit

protocol SearchHistoryCollectionViewDelegate: AnyObject {
    func didSelectItem(_ item: SearchHistoryCollectionViewItemProtocol)
}
typealias SHCollectionViewDelegate = SearchHistoryCollectionViewDelegate
final class SearchHistoryCollectionView: UIView {
    // MARK: - Outlets
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var historyCollectionView: UICollectionView!
    // MARK: Properties
    private var data = [SearchHistoryCollectionViewItemProtocol]()
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
    func configView(withData data: [SearchHistoryCollectionViewItemProtocol],
                    delegate: SHCollectionViewDelegate) {
        self.data = data
        self.containerView.isHidden = data.isEmpty
        self.delegate = delegate
        configCollectionView()
    }

    func setData(_ data: [SearchHistoryCollectionViewItemProtocol]) {
        self.data = data
        self.containerView.isHidden = data.isEmpty
        self.historyCollectionView.reloadData()
        self.historyCollectionView.scrollToFirstItem(animated: true)
    }
    private func configCollectionView() {
        historyCollectionView.delegate = self
        historyCollectionView.dataSource = self
        historyCollectionView.registerCellClass(SearchHistoryCell.self)
        historyCollectionView.contentInset = .init(top: 0,
                                                   left: 16,
                                                   bottom: 0,
                                                   right: 16)

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        historyCollectionView.collectionViewLayout = layout
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
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
        cell.configCell(withData: data[safe: indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard let item = self.data[safe: indexPath.item],
        !item.isSelected else { return }
        delegate?.didSelectItem(item)
    }
}
