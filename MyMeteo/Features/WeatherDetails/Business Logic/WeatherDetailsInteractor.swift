//
//  WeatherDetailsInteractor.swift
//  MyMeteo
//
//  Created by Sami Benmakhlouf on 30/11/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import Foundation

class WeatherDetailsInteractor {
  // MARK: - Property

  weak var output: WeatherDetailsInteractorOutput?

  // MARK: - Lifecycle

  init() {}
}

// MARK: - WeatherDetailsInteractorInput

extension WeatherDetailsInteractor: WeatherDetailsInteractorInput {

}
