//
//  UICollectionView + Extensions.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 19/03/2023.
//

import Foundation
import UIKit

extension UICollectionView {

    func registerCellClass<T: UICollectionViewCell>(_: T.Type) {
        let nibName = String(describing: T.self)
        let nib = UINib(nibName: nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: nibName)
    }
}
