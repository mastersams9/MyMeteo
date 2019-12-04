//
//  WeatherDetailsInteractorOutput.swift
//  MyMeteo
//
//  Created by Sami Benmakhlouf on 30/11/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import Foundation

/// sourcery: AutoMockable
protocol WeatherDetailsInteractorOutput: class {
    func updateCategories(cityName: String)
    func notifySuccess(item: WeatherDetailsInteractorItemProtocol)
    func notifyServerError()
}
