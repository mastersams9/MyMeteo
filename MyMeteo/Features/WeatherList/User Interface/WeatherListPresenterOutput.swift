//
//  WeatherListPresenterOutput.swift
//  MyMeteo
//
//  Created by Sami Benmakhlouf on 30/11/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import Foundation

protocol AlertParamsProtocol {
    var title: String { get }
    var message: String { get }
    var buttonOkTitle: String { get }
}

protocol WeatherListPresenterOutput: class {
    func displayTitle(_ title: String)
    func showLoader()
    func hideLoader()
    func reloadData()
    func reloadRows(_ indexPaths: [IndexPath])
    func displayError(_ params: AlertParamsProtocol)
}
