//
//  WeatherForecastInteractorOutput.swift
//  MyMeteo
//
//  Rahim template version 1.0
//
//  Created by Sami Benmakhlouf on 02/12/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import Foundation

public protocol WeatherForecastInteractorOutput: class {
    func notifySuccess()
    func notifyUnknownError()
    func notifyServerError()
    func notifyNetworkError()
    func notifyEmptyListError()
}
