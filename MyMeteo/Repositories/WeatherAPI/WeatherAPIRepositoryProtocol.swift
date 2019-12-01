//
//  WeatherAPIRepositoryProtocol.swift
//  MyMeteo
//
//  Created by Sami Benmakhlouf on 30/11/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import Foundation

enum WeatherAPIRepositoryUnit {
    case celsius
    case fahrenheit

    var description: String {
        switch self {
        case .celsius:
            return "Metric"
        case .fahrenheit:
            return "Imperial"
        default:
            return "Default"
        }
    }
}

/// sourcery: AutoMockable
protocol WeatherAPIWeatherResponseProtocol  {
    var id: Int? { get }
    var main: String? { get }
    var description: String? { get }
    var iconUrl: URL? { get }
}

/// sourcery: AutoMockable
protocol WeatherAPIMainResponseProtocol  {
    var temp: Double? { get }
    var pressure: Double? { get }
    var humidity: Int? { get }
    var tempMin: Double? { get }
    var tempMax: Double? { get }
}

/// sourcery: AutoMockable
protocol WeatherAPIWindResponseProtocol  {
    var speed: Double? { get }
    var deg: Double? { get }
}

/// sourcery: AutoMockable
protocol WeatherAPICityInfoResponseProtocol {
    var id: Int? { get }
    var name: String? { get }
    var weather: WeatherAPIWeatherResponseProtocol? { get }
    var main: WeatherAPIMainResponseProtocol? { get }
    var wind: WeatherAPIWindResponseProtocol? { get }
}

/// sourcery: AutoMockable
protocol WeatherAPIRepositoryInput {
    func getWeatherInfo(forCity city: String, withUnit unit: WeatherAPIRepositoryUnit, success: @escaping (WeatherAPICityInfoResponseProtocol) -> Void, failure: ((WeatherAPIRepositoryError, String) -> Void)?)
    func cancel(forCity city: String, withUnit unit: WeatherAPIRepositoryUnit)
}
