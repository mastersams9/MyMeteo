//
//  WeatherDetailsPresenterOutput.swift
//  MyMeteo
//
//  Created by Sami Benmakhlouf on 30/11/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import UIKit

enum CategoryView {
    case weatherDetails
    case weatherForecast
}

protocol WeatherDetailsPresenterViewModelProtocol {
    var name: NSAttributedString { get }
    var weatherIconImagePlaceholder: UIImage { get }
    var weatherIconImageURL: URL? { get }
    var weatherDescription: NSAttributedString? { get }
    var weatherCurrentTemperature: NSAttributedString? { get }
}


protocol WeatherDetailsPresenterOutput: class {
    func displayViewCategories(cityName: String)
    func displayError(_ params: AlertParamsProtocol)
    func updateView(viewModel: WeatherDetailsPresenterViewModelProtocol)
}
