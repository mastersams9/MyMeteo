//
//  WeatherAPIRepositoryProtocol.swift
//  MyMeteo
//
//  Created by Sami Benmakhlouf on 30/11/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import Foundation

protocol WeatherAPICoordProtocol: Codable  {
    var lon: Double? { get }
    var lat: Double? { get }
}

protocol WeatherAPIWeatherProtocol: Codable  {
    var id: Int? { get }
    var main: String? { get }
    var description: String? { get }
    var icon: String? { get }
}

protocol WeatherAPIMainProtocol: Codable  {
    var temp: Double? { get }
    var pressure: Double? { get }
    var humidity: Int? { get }
    var temp_min: Double? { get }
    var temp_max: Double? { get }
}

protocol WeatherAPIWindProtocol: Codable  {
    var speed: Double? { get }
    var deg: Double? { get }
}

protocol WeatherAPICloudsProtocol: Codable  {
    var all: Double? { get }
}

protocol WeatherAPISysProtocol: Codable  {
    var type: Int? { get }
    var id: Int? { get }
    var message: Double? { get }
    var country: String? { get }
    var sunrise: Double? { get }
    var sunset: Double? { get }
}

protocol WeatherAPICityInfoProtocol: Codable {
    var coord: WeatherAPICoordProtocol? { get }
    var weather: WeatherAPIWeatherProtocol? { get }
    var base: String? { get }
    var main: WeatherAPIMainProtocol? { get }
    var visibility: Double? { get }
    var wind: WeatherAPIWindProtocol? { get }
    var clouds: WeatherAPICloudsProtocol? { get }
    var dt: Int? { get }
    var sys: WeatherAPISysProtocol? { get }
    var id: Int? { get }
    var name: String? { get }
    var cod: Int? { get }
}

protocol WeatherAPIRepositoryInput {
    func getWeatherInfo(forCity city: String, withUnit unit: String, success: @escaping (WeatherAPICityInfoProtocol) -> Void, failure: ((WeatherAPIRepositoryError) -> Void)?)
}
