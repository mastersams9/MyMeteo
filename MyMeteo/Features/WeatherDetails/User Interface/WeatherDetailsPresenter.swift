//
//  WeatherDetailsPresenter.swift
//  MyMeteo
//
//  Created by Sami Benmakhlouf on 30/11/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import Foundation

final class WeatherDetailsPresenter {

  // MARK: - Property

  weak var output: WeatherDetailsPresenterOutput?
  private var interactor: WeatherDetailsInteractorInput
  private var router: WeatherDetailsRouterInput

  // MARK: - Lifecycle

  init(interactor: WeatherDetailsInteractorInput, router: WeatherDetailsRouterInput) {
    self.interactor = interactor
    self.router = router
  }

  // MARK: - Converting

}

// MARK: - WeatherDetailsPresenterInput

extension WeatherDetailsPresenter: WeatherDetailsPresenterInput {
  func viewDidLoad() {
  
  }
}

// MARK: - WeatherDetailsInteractorOutput

extension WeatherDetailsPresenter: WeatherDetailsInteractorOutput {

}
