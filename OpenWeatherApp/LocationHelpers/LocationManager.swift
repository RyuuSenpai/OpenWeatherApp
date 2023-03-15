//
//  LocationManager.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 15/03/2023.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate: AnyObject {
    func getCurrentLocation(completion: @escaping (CLLocation?) -> Void)
}
final class LocationManager: NSObject, LocationManagerDelegate {
    
    static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    private var locationCompletionHandler: ((CLLocation?) -> Void)?
    
    private override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func getCurrentLocation(completion: @escaping (CLLocation?) -> Void) {
        locationCompletionHandler = completion
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        locationCompletionHandler?(location)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint("Failed to get user location: \(error.localizedDescription)")
        locationCompletionHandler?(nil)
        locationManager.stopUpdatingLocation()
    }
}


