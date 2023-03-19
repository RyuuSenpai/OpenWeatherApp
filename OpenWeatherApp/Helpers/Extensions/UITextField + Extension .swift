//
//  UITextField + Extension .swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 19/03/2023.
//

import Foundation
import UIKit

extension UITextField {
    func addLeadingPadding(_ padding: CGFloat = 12) {
        let paddingView = UIView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: padding,
                                               height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
