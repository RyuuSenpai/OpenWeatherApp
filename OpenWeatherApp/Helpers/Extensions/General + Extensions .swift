//
//  General + Extensions .swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 18/03/2023.
//

import Foundation

extension Numeric {
    var stringValue: String {
        String(describing: self)
    }
}

extension Double {
    var roundNumber: String {
        Int(self.rounded()).stringValue
    }
}
extension Array {
    /// Subscript that returns nil instead of crashing when accessing an out-of-bounds index.
    subscript(safe index: Int) -> Element? {
        get {
            return indices ~= index ? self[index] : nil
        }
        set {
            if let newValue = newValue, indices ~= index {
                self[index] = newValue
            }
        }
    }
}


