//
//  WeatherForecastInteractorOutput.swift
//  MyMeteo
//
//
//
//  Created by Sami Benmakhlouf on 02/12/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import Foundation

/// sourcery: AutoMockable
public protocol WeatherForecastInteractorOutput: class {
    func notifySuccess()
    func notifyUnknownError()
    func notifyServerError()
    func notifyNetworkError()
    func notifyEmptyListError()
}
