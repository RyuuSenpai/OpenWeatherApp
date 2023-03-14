//
//  APIClient.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 14/03/2023.
//

import Foundation
import Alamofire

typealias APIResult<T: Codable> = Result<T, Error>

enum RequestMethod {
    case get
    case post(parameters: [String: Any])
}
protocol APIClientProtocol {
    func performRequest<T: Codable>(url: String,
                                    method: RequestMethod,
                                    completion: @escaping (APIResult<T>) -> Void)
}

final class APIClient: APIClientProtocol {
    func performRequest<T: Codable>(url: String,
                                    method: RequestMethod,
                                    completion: @escaping (APIResult<T>) -> Void) {
        let requestMethod: HTTPMethod
        var requestParameters: [String: Any]?
        switch method {
        case .post(let parameters):
            requestMethod = .post
            requestParameters = parameters
        case .get:
            requestMethod = .get
        }
        AF.request(url,
                   method: requestMethod,
                   parameters: requestParameters)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
