//
//  APIClient.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 14/03/2023.
//

import Foundation
import Alamofire

typealias APIResult<Entity: Codable> = Result<Entity, Error>

enum RequestMethod {
    case get
    case post(parameters: [String: Any])
}
protocol APIClientProtocol {
    func performRequest<Entity: Codable>(router: APIRouter,
                                         method: RequestMethod,
                                         completion: @escaping (APIResult<Entity>) -> Void)
}

final class APIClient: APIClientProtocol {
    static let shared = APIClient()
    private let baseUrl = "http://api.openweathermap.org"
    private let accessKey = "f5cb0b965ea1564c50c6f1b74534d823"

    private init() {}

    func performRequest<Entity: Codable>(router: APIRouter,
                                         method: RequestMethod,
                                         completion: @escaping (APIResult<Entity>) -> Void) {
        let url = baseUrl + router.path + "&appid=\(accessKey)"
        debugPrint(url)
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
        .responseDecodable(of: Entity.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
