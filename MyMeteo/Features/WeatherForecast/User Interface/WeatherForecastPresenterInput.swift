//
//  WeatherForecastPresenterInput.swift
//  MyMeteo
//
//
//
//  Created by Sami Benmakhlouf on 02/12/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import UIKit

protocol WeatherForecastPresenterViewModelProtocol {
    var weatherIconImagePlaceholder: UIImage { get }
    var weatherIconImageURL: URL? { get }
    var weatherMinMaxTemperature: NSAttributedString? { get }
    var date: NSAttributedString? { get }
}

protocol WeatherForecastPresenterInput {
    func viewDidLoad()
    func numberOfItemsInSection(_ section: Int) -> Int
    func viewModelForRowAtIndexPath(_ indexPath: IndexPath) -> WeatherForecastPresenterViewModelProtocol
}
