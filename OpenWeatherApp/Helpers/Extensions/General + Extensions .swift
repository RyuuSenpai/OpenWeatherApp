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

extension Array {
    /// Subscript that returns nil instead of crashing when accessing an out-of-bounds index.
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
