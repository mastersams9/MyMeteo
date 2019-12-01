//
//  WeatherListInteractor.swift
//  MyMeteo
//
//  Rahim template version 1.0
//
//  Created by Sami Benmakhlouf on 30/11/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import Foundation

class WeatherListInteractor {
  // MARK: - Property

  weak var output: WeatherListInteractorOutput?

  // MARK: - Lifecycle

  init() {}
}

// MARK: - WeatherListInteractorInput

extension WeatherListInteractor: WeatherListInteractorInput {

}
