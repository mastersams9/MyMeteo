//
//  WeatherListInteractorInput.swift
//  MyMeteo
//
//  Created by Sami Benmakhlouf on 30/11/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import Foundation

enum WeatherListInteractorItemUnit {
    case celsius
}

protocol WeatherListInteractorItemProtocol {
    var name: String { get }
    var weatherIconUrl: URL? { get }
    var weatherDescription: String? { get }
    var weatherCurrentTemperature: Double? { get }
    var weatherMinTemperature: Double? { get }
    var weatherMaxTemperature: Double? { get }
    var temperatureUnit: WeatherListInteractorItemUnit { get }

}

protocol WeatherListInteractorInput {
    var output: WeatherListInteractorOutput? { get set }

    func retrieve()
    func numberOfCategories() -> Int
    func numberOfItemsForCategoryIndex(_ categoryIndex: Int) -> Int
    func item(forIndex index: Int, atCategoryIndex categoryIndex: Int) -> WeatherListInteractorItemProtocol?
    func preloadItems(at indexes: [Int]?)
    func cancelItems(at indexes: [Int]?)
    func didSelect()
}
