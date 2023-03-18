//
//  CardView.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 19/03/2023.
//

import Foundation
import UIKit

@IBDesignable
class CardView: UIView {

    // MARK: - Properties
    @IBInspectable var cornerRadiusValue: CGFloat = 8.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var shadowColor: UIColor = UIColor.black {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }

    @IBInspectable var shadowOpacity: Float = 0.2 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }

    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 1) {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }

    @IBInspectable var shadowRadius: CGFloat = 4.0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCardView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCardView()
    }

    // MARK: - Private methods
    private func setupCardView() {
        layer.cornerRadius = cornerRadiusValue
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
    }
}

