//
//  WeatherDetailsInteractorOutput.swift
//  MyMeteo
//
//  Created by Sami Benmakhlouf on 30/11/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import Foundation

public enum Category: Int {
    case weatherDetails = 0
    case weatherForecast
}

protocol WeatherDetailsInteractorOutput: class {
    func updateCategories(_ categories: [Category], cityName: String)
    func notifySuccess(item: WeatherDetailsInteractorItemProtocol)
    func notifyServerError()
}
