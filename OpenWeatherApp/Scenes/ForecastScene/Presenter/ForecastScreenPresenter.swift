//
//  ForecastScreenPresenter.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 18/03/2023.
//

import Foundation

final class ForecastScreenPresenter {
    // MARK: - Properites
    private var view: ForecastScreenViewProtocol?
    private var interactor: ForecastScreenPresenterInteractorProtocol?
    private var router: ForecastScreenRouterProtocol?

    // MARK: - Init
    init(view: ForecastScreenViewProtocol?,
         interactor: ForecastScreenPresenterInteractorProtocol?,
         router: ForecastScreenRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}
// MARK: - Conforming to ForecaseScreenPresenterProtocol
extension ForecastScreenPresenter: ForecaseScreenPresenterProtocol {
    func didSelectItem(_ item: SearchHistoryCollectionViewItemProtocol) {
        interactor?.didSelectItem(item)
    }

    func viewDidLoad() {
        interactor?.fetchSearchHistory()
    }
}
// MARK: - Conforming to ForecastScreenInteractorOutput
extension ForecastScreenPresenter: ForecastScreenInteractorOutput {
    func updateSearchHistoryList(with data: [SearchHistoryCollectionViewItemProtocol]) {
        self.view?.updateSearchHistoryList(with: data)
    }

    func didFetchForecast(data: ForecastModel.Forecast) {
        self.view?.displayForecastList(with: .init(name: data.city?.name ?? "",
                                                   country: data.city?.country ?? "",
                                                   items: getForecastItems(from: data.list)))
    }

    private func getForecastItems(from data: [ForecastModel.WeatherDetails]?) -> [ForecastScreenEntity.Item] {
        let weatherList = data ?? []
        let items = weatherList.map {
            let weatherDetails = DashboardEntity(currentTemp: $0.main?.temp ?? 0.0,
                                                 cloudsSate: $0.weather?.first?.main ?? "",
                                                 cloudsStateDescription: $0.weather?.first?.description ?? "",
                                                 cloudStateIconName: $0.weather?.first?.icon ?? "",
                                                 windSpeedValue: $0.wind?.speed ?? 0.0,
                                                 humidityValue: $0.main?.humidity ?? 0,
                                                 showIcons: false)
            return ForecastScreenEntity.Item(currentTemp: $0.main?.temp?.roundNumber ?? "",
                                             highestTemp: $0.main?.tempMax?.roundNumber ?? "",
                                             lowestTemp: $0.main?.tempMin?.roundNumber ?? "",
                                             weatherDetails: weatherDetails,
                                             date: $0.dtTxt ?? "")
        }
        return items
    }
    func didSearhForQuery(query: String) {
        guard !query.isEmpty else { return }
        interactor?.didSearhForQuery(searchQuery: .init(query: query))
    }
}
