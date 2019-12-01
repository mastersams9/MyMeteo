//
//  WeatherListModuleFactory.swift
//  MyMeteo
//
//  Rahim template version 1.0
//
//  Created by Sami Benmakhlouf on 30/11/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import UIKit

class WeatherListModuleFactory {

  func makeView() -> WeatherListViewController? {

    let interactor = WeatherListInteractor()
    let router = WeatherListRouter()
    let presenter = WeatherListPresenter(interactor: interactor, router: router)
    interactor.output = presenter

    let storyboard = UIStoryboard(name: "WeatherList", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: "WeatherListViewController") as? WeatherListViewController
    viewController?.presenter = presenter
    presenter.output = viewController
    router.viewController = viewController

    return viewController
  }
}
