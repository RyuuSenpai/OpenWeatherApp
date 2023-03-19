//
//  LocationManager.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 15/03/2023.
//

import Foundation
import CoreLocation

enum LocationAuthorizationStatus {
    case notDetermined
    case denied
    case authorized
}

protocol LocationAuthorizationDelegate: AnyObject {
    func authorizationStatusChanged(status: LocationAuthorizationStatus)
}

protocol LocationManagerDelegate: AnyObject {
    func getCurrentLocation(completion: @escaping (CLLocation?) -> Void)
    func requestAuthorization()
}

final class LocationManager: NSObject, LocationManagerDelegate {

    static let shared = LocationManager()

    private let locationManager = CLLocationManager()
    private var locationCompletionHandler: ((CLLocation?) -> Void)?
    private var userLastLocation: CLLocation?
    private var didUpdateLocation = false
    weak var authorizationDelegate: LocationAuthorizationDelegate?

    var authorizationStatus: LocationAuthorizationStatus {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            return .authorized
        case .denied:
            return .denied
        default:
            return .notDetermined
        }
    }

    private override init() {
        super.init()
        locationManager.delegate = self
    }

    deinit {
        locationManager.stopUpdatingLocation()
    }

    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }

    func getCurrentLocation(completion: @escaping (CLLocation?) -> Void) {
        locationCompletionHandler = completion
        switch authorizationStatus {
        case .authorized:
            locationManager.startUpdatingLocation()
        case .denied:
            locationCompletionHandler?(nil)
        case .notDetermined:
            requestAuthorization()
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last,
              !didUpdateLocation else { return }
        userLastLocation = location
        didUpdateLocation = true
        locationCompletionHandler?(location)
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint("Failed to get user location: \(error.localizedDescription)")
        locationCompletionHandler?(nil)
        locationManager.stopUpdatingLocation()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationDelegate?.authorizationStatusChanged(status: authorizationStatus)
    }
}
