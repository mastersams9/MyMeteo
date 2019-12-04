//
//  WeatherDetailsInteractorInput.swift
//  MyMeteo
//
//  Created by Sami Benmakhlouf on 30/11/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import Foundation

enum WeatherDetailsInteractorItemUnit {
    case celsius
    case fahrenheit
}

protocol WeatherDetailsInteractorItemProtocol {
    var name: String { get }
    var weatherIconUrl: URL? { get }
    var weatherDescription: String? { get }
    var weatherCurrentTemperature: Double? { get }
    var weatherMinTemperature: Double? { get }
    var weatherMaxTemperature: Double? { get }
    var temperatureUnit: WeatherDetailsInteractorItemUnit { get }
}

protocol WeatherDetailsInteractorInput {
    var output: WeatherDetailsInteractorOutput? { get set }
    func prepare()
    func retrieve()
}
