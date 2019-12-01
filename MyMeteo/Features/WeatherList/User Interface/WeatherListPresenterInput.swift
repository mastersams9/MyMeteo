//
//  WeatherListPresenterInput.swift
//  MyMeteo
//
//  Created by Sami Benmakhlouf on 30/11/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import UIKit

protocol WeatherListPresenterViewModelProtocol {
    var name: NSAttributedString { get }
    var weatherIconImagePlaceholder: UIImage { get }
    var weatherIconImageURL: URL? { get }
    var weatherDescription: NSAttributedString? { get }
    var weatherCurrentTemperature: NSAttributedString? { get }
    var weatherMinMaxTemperature: NSAttributedString? { get }
}

protocol WeatherListPresenterInput {
    func viewDidLoad()
    func numberOfSections() -> Int
    func numberOfRowsInSection(_ section: Int) -> Int
    func viewModelForRowAtIndexPath(_ indexPath: IndexPath) -> WeatherListPresenterViewModelProtocol
    func prefetchRowsAtIndexPaths(_ indexPaths: [IndexPath]?)
    func cancelPrefetchingForRowsAt(_ indexPaths: [IndexPath]?)
}
