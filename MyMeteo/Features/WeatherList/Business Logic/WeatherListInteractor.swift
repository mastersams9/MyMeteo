//
//  WeatherListInteractor.swift
//  MyMeteo
//
//  Created by Sami Benmakhlouf on 30/11/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import Foundation

class WeatherListInteractor {
    // MARK: - Property

    weak var output: WeatherListInteractorOutput?
    private let franceCitiesRepositories: FranceCitiesRepositoryProtocol
    private let weatherAPIRepository: WeatherAPIRepositoryInput
    private var items: [WeatherListInteractorItem] = []
    private var currentTemperatureUnit: WeatherListInteractorItemUnit = .celsius

    // MARK: - Lifecycle

    init(franceCitiesRepository: FranceCitiesRepositoryProtocol, weatherAPIRepository: WeatherAPIRepositoryInput) {
        self.franceCitiesRepositories = franceCitiesRepository
        self.weatherAPIRepository = weatherAPIRepository
    }

    // MARK: - Privates

    private func updateItem(forCityName cityName: String) {
        DispatchQueue.background.async {
            guard let refreshedIndex: Int = self.items.firstIndex(where: { $0.name == cityName }) else {
                return
            }

            DispatchQueue.main.async {
                self.output?.updateItem(atIndex: refreshedIndex, forCategoryIndex: 0)
            }
        }
    }

    private func convertToWeatherAPIRepositoryUnit() -> WeatherAPIRepositoryUnit {
        switch currentTemperatureUnit {
        case .celsius:
            return .celsius
        default:
            return .fahrenheit
        }
    }

    private func prefetchItems(forStartIndex startIndex: Int, toEndIndex endIndex: Int) {
        for index in startIndex...endIndex {
            if let item = items[safe: index], item.isRefreshed == false {
                print("isRefreshed : false - item.name : \(item.name)")
                self.weatherAPIRepository.getWeatherInfo(forCity: item.name,
                                                         withUnit: convertToWeatherAPIRepositoryUnit(),
                                                         success: { [weak self] info in
                                                            item.weatherCurrentTemperature = info.main?.temp
                                                            item.weatherMinTemperature = info.main?.tempMin
                                                            item.weatherMaxTemperature = info.main?.tempMax
                                                            item.weatherDescription = info.weather?.description
                                                            item.weatherIconUrl = info.weather?.iconUrl
                                                            item.isRefreshed = true
                                                            self?.updateItem(forCityName: item.name)
                }) { [weak self] (_, city) in
                    self?.updateItem(forCityName: city)
                }
            } else {
                print("isRefreshed : true - item.name : \(items[safe: index]?.name)")
            }
        }
    }

    private func cancelItems(forStartIndex startIndex: Int, toEndIndex endIndex: Int) {
        for index in startIndex...endIndex {
            if let item = items[safe: index], item.isRefreshed == false {
                print("isRefreshed : false - item.name : \(item.name)")
                self.weatherAPIRepository.cancel(forCity: item.name,
                                                         withUnit: convertToWeatherAPIRepositoryUnit())
            }
        }
    }
}

// MARK: - WeatherListInteractorInput

extension WeatherListInteractor: WeatherListInteractorInput {

    func retrieve() {
        output?.notifyLoading()
        output?.setDefaultValues()
        franceCitiesRepositories.fetch(success: { [weak self] franceCitiesList in
            guard let self = self else { return }
            if franceCitiesList.isEmpty {
                self.output?.notifyFranceCitiesEmptyListError()
                return
            }

            self.items = franceCitiesList.compactMap {

                guard let id = $0.id, let name = $0.name else {
                    return nil
                }

                return WeatherListInteractorItem(id: id,
                                                 name: name,
                                                temperatureUnit: self.currentTemperatureUnit)
            }

            self.output?.updateItems()
        }) { [weak self] _ in
            self?.output?.notifyFranceCitiesListNotFoundError()
        }
    }
    
    func numberOfCategories() -> Int {
        return 1
    }

    func numberOfItemsForCategoryIndex(_ categoryIndex: Int) -> Int {
        return items.count
    }

    func item(forIndex index: Int, atCategoryIndex categoryIndex: Int) -> WeatherListInteractorItemProtocol? {
        if categoryIndex != 0 {
            return nil
        }
        return items[safe: index]
    }

    func preloadItems(at indexes: [Int]?) {
        guard let indexes = indexes else { return }
        DispatchQueue.background.async {
            let sortedIndexes = indexes.sorted(by: { $0 < $1 })
            if let firstIndex = sortedIndexes.first, let lastIndex = sortedIndexes.last {
               self.prefetchItems(forStartIndex: firstIndex, toEndIndex: lastIndex)
            }
        }
    }

    func cancelItems(at indexes: [Int]?) {
        guard let indexes = indexes else { return }
        DispatchQueue.background.async {
            let sortedIndexes = indexes.sorted(by: { $0 < $1 })
            if let firstIndex = sortedIndexes.first, let lastIndex = sortedIndexes.last {
                self.cancelItems(forStartIndex: firstIndex, toEndIndex: lastIndex)
            }
        }
    }
}

// Mark: - Privates

private class WeatherListInteractorItem: WeatherListInteractorItemProtocol {
    private let id: String
    fileprivate var isRefreshed: Bool
    fileprivate let name: String
    fileprivate var weatherIconUrl: URL?
    fileprivate var weatherDescription: String?
    fileprivate var weatherCurrentTemperature: Double?
    fileprivate var weatherMinTemperature: Double?
    fileprivate var weatherMaxTemperature: Double?
    fileprivate var temperatureUnit: WeatherListInteractorItemUnit

    init(id: String,
         name: String,
         temperatureUnit: WeatherListInteractorItemUnit) {
        self.id = id
        self.name = name
        self.temperatureUnit = temperatureUnit
        self.isRefreshed = false
    }
}
