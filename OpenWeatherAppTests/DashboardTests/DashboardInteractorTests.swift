//
//  DashboardInteractorTests.swift
//  OpenWeatherAppTests
//
//  Created by Eslam Abo El Fetouh on 15/03/2023.
//

import XCTest
@testable import OpenWeatherApp
/// UnitTest DashboardInteractor Using Factory Methods instead of setup() and teardown()
final class DashboardInteractorTests: XCTestCase {

    // MARK: - Factory Methods
    func weatherLoaderMockFactory() -> WeatherLoaderMock {
        WeatherLoaderMock()
    }

    func presenterMockFactory() -> DashboardPresenterOutputMock {
        DashboardPresenterOutputMock()
    }

    func interactorFactory(loader: WeatherLoaderMock,
                           preseneter: DashboardPresenterOutputMock? = nil) -> DashboardInteractor {
        let interactor = DashboardInteractor(weatherLoader: loader)
        interactor.presenter = preseneter
        return interactor
    }
    // MARK: - Tests
    func testFetchWeatherDataSuccess() {
        // Given
        let loaderMock = weatherLoaderMockFactory()
        let presenterMock = presenterMockFactory()
        let interactor = interactorFactory(loader: loaderMock,
                                           preseneter: presenterMock)
        let latitude: Double = 30.793719
        let longitude: Double = 30.998633
        let expectedResult: APIResult<DashboardEntity.Weather> = .success(DashboardEntity.Weather())
        // Set the expected result on the mock loader
        loaderMock.expectedResult = expectedResult

        // When
        interactor.fetchWeatherData(with: latitude, longitude)

        // Then
        XCTAssertEqual(loaderMock.loadWeatherCalled, true)
        XCTAssertEqual(presenterMock.displayWeatherDataCalled, true)
        XCTAssertNil(presenterMock.error)
        XCTAssertEqual(presenterMock.requestDidFail, false)

    }

    func testFetchWeatherDataFailure() {
        // Given
        let loaderMock = weatherLoaderMockFactory()
        let presenterMock = presenterMockFactory()
        let interactor = interactorFactory(loader: loaderMock,
                                           preseneter: presenterMock)
        let latitude: Double = 30.793719
        let longitude: Double = 30.998633
        let expectedError = APIError.badRequest
        let expectedResult: APIResult<DashboardEntity.Weather> = .failure(expectedError)
        // Set the expected result on the mock loader
        loaderMock.expectedResult = expectedResult

        // When
        interactor.fetchWeatherData(with: latitude, longitude)

        // Then
        XCTAssertEqual(loaderMock.loadWeatherCalled, true)
        XCTAssertEqual(presenterMock.error, expectedError)
        XCTAssertEqual(presenterMock.requestDidFail, true)
        XCTAssertEqual(presenterMock.displayWeatherDataCalled, false)
    }
}
