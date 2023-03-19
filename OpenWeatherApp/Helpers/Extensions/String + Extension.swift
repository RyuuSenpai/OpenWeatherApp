//
//  String + Extension.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 18/03/2023.
//

import Foundation

extension String {
    var imageUrlPath: String {
        APIClient.shared.baseUrl + self + ".png"
    }
    var urlHostCharactersAllowed: String {
        self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
}
