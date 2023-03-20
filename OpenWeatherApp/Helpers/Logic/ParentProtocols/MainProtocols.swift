//
//  MainProtocols.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 20/03/2023.
//

import Foundation

protocol MainSharedMethodsProtocol: AnyObject {
}
protocol InteractorProtocol: MainSharedMethodsProtocol {
    
}

protocol PresenterProtocol: MainSharedMethodsProtocol {
    func showAlert(withTitle title: String,
                   message: String,
                   buttonTitle: String)
}

protocol ViewProtocol: MainSharedMethodsProtocol {
    func showAlert(withTitle title: String,
                   message: String,
                   buttonTitle: String)
}
