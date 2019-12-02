//
//  WeatherForecastInteractor.swift
//  MyMeteo
//
//  Rahim template version 1.0
//
//  Created by Sami Benmakhlouf on 02/12/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import Foundation

class WeatherForecastInteractor {
    // MARK: - Property
    
    weak var output: WeatherForecastInteractorOutput?
    
    private let cityName: String
    private let weatherAPIRepository: WeatherAPIRepositoryInput
    private var items: [WeatherForecastInteractorItem] = []
    private var currentTemperatureUnit: WeatherForecastInteractorItemUnit = .celsius
    
    // MARK: - Lifecycle
    
    init(cityName: String, weatherAPIRepository: WeatherAPIRepositoryInput) {
        self.cityName = cityName
        self.weatherAPIRepository = weatherAPIRepository
    }
    
    private func getDaysList() -> [String] {
        var dates: [String] = []
        let currentDate = Date()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        for i in 1...5 {
            if let date = Calendar.current.date(byAdding: .day, value: i, to: currentDate) {
                dates.append(formatter.string(from: date))
            }
        }
        return dates
    }
    
    private func getWeatherForecastInteractorItemList(weatherAPIForecastListResponse: [WeatherAPIForecastResponseProtocol]) -> [WeatherForecastInteractorItem] {
        
        var weatherForecastInteractorItems: [WeatherForecastInteractorItem] = []
        let dates: [String] = self.getDaysList()
        
        for day in dates {
            let dayWeather = weatherAPIForecastListResponse.filter{
                ($0.date?.contains(day) ?? false)
            }
            let minimalWeather = dayWeather.min { ($0.weatherTemperature ?? 0) < ($1.weatherTemperature ?? 0) }
            let maximalWeather = dayWeather.max { ($0.weatherTemperature ?? 0) < ($1.weatherTemperature ?? 0) }

            
            weatherForecastInteractorItems.append(WeatherForecastInteractorItem(weatherMinTemperature: minimalWeather?.weatherTemperature, weatherMaxTemperature: maximalWeather?.weatherTemperature, temperatureUnit: .celsius, weatherIconUrl: minimalWeather?.iconUrl, date: day))
        }
        
        return weatherForecastInteractorItems
    }
    
}

// MARK: - WeatherForecastInteractorInput

extension WeatherForecastInteractor: WeatherForecastInteractorInput {
    func retrieve() {
        self.weatherAPIRepository.getWeatherForecastInfo(forCity: cityName, withUnit: .celsius, success: { [weak self] weatherForecastListResponse in
            guard let self = self else {
                return
            }
            self.items = self.getWeatherForecastInteractorItemList(weatherAPIForecastListResponse: weatherForecastListResponse)
        }, failure: { [weak self] error in
            switch error {
            case .network:
                self?.output?.notifyNetworkError()
            case .server:
                self?.output?.notifyServerError()
            case .noData:
                self?.output?.notifyEmptyListError()
            case .unknown:
                self?.output?.notifyUnknownError()
            }
        })
    }
    
    func numberOfItemsForSection(_ section: Int) -> Int {
        return self.items.count
    }
    
    func item(forIndex index: Int, atCategoryIndex categoryIndex: Int) -> WeatherForecastInteractorItemProtocol? {
        return self.items[safe: index]
    }
    
}

// Mark: - Privates

private struct WeatherForecastInteractorItem: WeatherForecastInteractorItemProtocol {
    fileprivate var weatherMinTemperature: Double?
    fileprivate var weatherMaxTemperature: Double?
    fileprivate var temperatureUnit: WeatherForecastInteractorItemUnit
    fileprivate var weatherIconUrl: URL?
    fileprivate var date: String?
}
