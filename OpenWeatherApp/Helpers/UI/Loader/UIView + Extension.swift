//
//  UIView + ActivityIndictor.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 18/03/2023.
//

import Foundation
import UIKit

extension UIView {
    func loadFromNib() {
        guard let subView = UINib(nibName: "\(type(of: self))", bundle: nil)
            .instantiate(withOwner: self, options: nil).first as? UIView
        else { return }

        subView.frame = bounds
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        addSubview(subView)
    }
}
