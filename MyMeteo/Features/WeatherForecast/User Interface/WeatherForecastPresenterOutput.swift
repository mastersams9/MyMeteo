//
//  WeatherForecastPresenterOutput.swift
//  MyMeteo
//
//
//
//  Created by Sami Benmakhlouf on 02/12/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import Foundation

protocol WeatherForecastPresenterOutput: class {
    func reloadData()
    func displayError(_ params: AlertParamsProtocol)
}
