//
//  WeatherDetailsModuleFactory.swift
//  MyMeteo
//
//  Created by Sami Benmakhlouf on 30/11/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import UIKit

class WeatherDetailsModuleFactory {

  func makeView() -> WeatherDetailsViewController? {

    let interactor = WeatherDetailsInteractor()
    let router = WeatherDetailsRouter()
    let presenter = WeatherDetailsPresenter(interactor: interactor, router: router)
    interactor.output = presenter

    let storyboard = UIStoryboard(name: "WeatherDetails", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: "WeatherDetailsViewController") as? WeatherDetailsViewController
    viewController?.presenter = presenter
    presenter.output = viewController
    router.viewController = viewController

    return viewController
  }
}
