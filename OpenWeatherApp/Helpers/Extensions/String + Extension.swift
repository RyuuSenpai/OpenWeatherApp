//
//  String + Extension.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 18/03/2023.
//

import Foundation

extension String {
    var imageUrlPath: String {
        APIClient.shared.baseUrl + "/img/w/" + self + ".png"
    }
    var imageUrl: URL? {
        URL(string: self.imageUrlPath)
    }
    var urlHostCharactersAllowed: String {
        self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }

    var removeWhiteSpaces: String {
        return self.trimmingCharacters(in: .whitespaces)
    }

    func formattedDateTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: self)

        guard let unwrappedDate = date else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, yyyy-MM-dd h:mm a"
        return formatter.string(from: unwrappedDate)
    }

}
