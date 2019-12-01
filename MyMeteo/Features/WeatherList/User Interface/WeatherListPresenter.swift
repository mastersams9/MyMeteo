//
//  WeatherListPresenter.swift
//  MyMeteo
//
//  Rahim template version 1.0
//
//  Created by Sami Benmakhlouf on 30/11/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import Foundation

final class WeatherListPresenter {

  // MARK: - Property

  weak var output: WeatherListPresenterOutput?
  private var interactor: WeatherListInteractorInput
  private var router: WeatherListRouterInput

  // MARK: - Lifecycle

  init(interactor: WeatherListInteractorInput, router: WeatherListRouterInput) {
    self.interactor = interactor
    self.router = router
  }

  // MARK: - Converting

}

// MARK: - WeatherListPresenterInput

extension WeatherListPresenter: WeatherListPresenterInput {
  func viewDidLoad() {
  
  }
}

// MARK: - WeatherListInteractorOutput

extension WeatherListPresenter: WeatherListInteractorOutput {

}
