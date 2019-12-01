//
//  WeatherDetailsViewController.swift
//  MyMeteo
//
//  Created by Sami Benmakhlouf on 30/11/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import UIKit

class WeatherDetailsViewController: UIViewController {

  // MARK: - Property

  var presenter: WeatherDetailsPresenterInput!

  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.presenter?.viewDidLoad()
  }
}

// MARK: - WeatherDetailsPresenterOutput

extension WeatherDetailsViewController: WeatherDetailsPresenterOutput {

}
