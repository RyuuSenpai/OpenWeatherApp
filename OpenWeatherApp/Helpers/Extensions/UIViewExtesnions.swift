//
//  UIViewExtesnions.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 14/03/2023.
//

import Foundation
import UIKit

// MARK: - UIViewExtesnion
extension UIView {
    func addShadow(shadowColor: UIColor = .black,
                   shadowOffset: CGSize = .zero,
                   shadowOpacity: Float = 0.2,
                   shadowRadius: CGFloat = 5.0) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.masksToBounds = false
    }
}

// MARK: - IBInspectable Extension
extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    @IBInspectable var backgroundColor: UIColor? {
        get {
            return self.backgroundColor
        }
        set {
            self.backgroundColor = newValue
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}
// MARK: - UICollectionView
extension UICollectionView {
    func scrollToFirstItem(animated: Bool) {
        guard numberOfItems(inSection: 0) > 0 else { return }
        let firstIndexPath = IndexPath(item: 0, section: 0)
        scrollToItem(at: firstIndexPath, at: .left, animated: animated)
    }
}
