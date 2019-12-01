//
//  WeatherListModuleFactory.swift
//  MyMeteo
//
//  Created by Sami Benmakhlouf on 30/11/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import UIKit

class WeatherListModuleFactory {

  func makeView() -> UIViewController {

    let fileReader = FileReader()
    let franceCitiesRepository = FranceCitiesRepository(fileReader: fileReader)
    let api = WeatherAPI()
    let weatherAPIRepository = WeatherAPIRepository(api: api)
    let interactor = WeatherListInteractor(franceCitiesRepository: franceCitiesRepository, weatherAPIRepository: weatherAPIRepository)
    let router = WeatherListRouter()
    let presenter = WeatherListPresenter(interactor: interactor, router: router)
    interactor.output = presenter

    let storyboard = UIStoryboard(name: "WeatherList", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: "WeatherListViewController") as? WeatherListViewController
    viewController?.imageLoader = MyMeteoImageLoader()
    viewController?.presenter = presenter
    presenter.output = viewController
    router.viewController = viewController

    return viewController ?? UIViewController()
  }
}
