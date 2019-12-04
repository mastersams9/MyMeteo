//
//  WeatherForecastInteractorInput.swift
//  MyMeteo
//
//
//  Created by Sami Benmakhlouf on 02/12/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import Foundation

enum WeatherForecastInteractorItemUnit {
    case celsius
    case fahrenheit
}
/// sourcery: AutoMockable
protocol WeatherForecastInteractorItemProtocol {
    var temperatureUnit: WeatherForecastInteractorItemUnit { get }
    var weatherMinTemperature: Double? { get }
    var weatherMaxTemperature: Double? { get }
    var weatherIconUrl: URL? { get }
    var date: String? { get }
}

/// sourcery: AutoMockable
protocol WeatherForecastInteractorInput {
    var output: WeatherForecastInteractorOutput? { get set }
    
    func retrieve()
    func numberOfItemsForSection(_ section: Int) -> Int
    func item(forIndex index: Int, atCategoryIndex categoryIndex: Int) -> WeatherForecastInteractorItemProtocol?
}

