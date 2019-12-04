//
//  WeatherDetailsInteractor.swift
//  MyMeteo
//
//  Created by Sami Benmakhlouf on 30/11/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import Foundation

class WeatherDetailsInteractor {
    // MARK: - Property
    
    weak var output: WeatherDetailsInteractorOutput?
    private let weatherAPIRepository: WeatherAPIRepositoryInput
    private var currentTemperatureUnit: WeatherListInteractorItemUnit = .celsius
    private let city: String
    private var weatherDetailsItem: WeatherDetailsInteractorItem?
    
    // MARK: - Lifecycle
    
    init(cityName city: String, weatherAPIRepository: WeatherAPIRepositoryInput) {
        self.city = city
        self.weatherAPIRepository = weatherAPIRepository
    }
}

// MARK: - WeatherDetailsInteractorInput

extension WeatherDetailsInteractor: WeatherDetailsInteractorInput {
    func prepare() {
        output?.updateCategories([.weatherDetails, .weatherForecast], cityName: city)
    }
    func retrieve() {
        self.weatherAPIRepository.getWeatherInfo(forCity: self.city,
                                                 withUnit: .celsius,
                                                 success: { [weak self] info in
                                                    guard let self = self else { return }
                                                    let item = WeatherDetailsInteractorItem(name: self.city, weatherIconUrl: info.weather?.iconUrl, weatherDescription: info.weather?.description, weatherCurrentTemperature: info.main?.temp, weatherMinTemperature: info.main?.tempMin, weatherMaxTemperature: info.main?.tempMax, temperatureUnit: .celsius)
                                                    self.weatherDetailsItem = item
                                                    self.output?.notifySuccess(item: item)
         
        }) { [weak self] (_, _) in
            self?.output?.notifyServerError()
        }
    }
}

// Mark: - Privates

private struct WeatherDetailsInteractorItem: WeatherDetailsInteractorItemProtocol {
    fileprivate let name: String
    fileprivate var weatherIconUrl: URL?
    fileprivate var weatherDescription: String?
    fileprivate var weatherCurrentTemperature: Double?
    fileprivate var weatherMinTemperature: Double?
    fileprivate var weatherMaxTemperature: Double?
    fileprivate var temperatureUnit: WeatherDetailsInteractorItemUnit
}
