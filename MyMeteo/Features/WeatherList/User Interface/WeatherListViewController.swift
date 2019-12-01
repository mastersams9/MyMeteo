//
//  WeatherListViewController.swift
//  MyMeteo
//
//  Rahim template version 1.0
//
//  Created by Sami Benmakhlouf on 30/11/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import UIKit

class WeatherListViewController: UIViewController {

  // MARK: - Property

  var presenter: WeatherListPresenterInput!

  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.presenter?.viewDidLoad()
  }
}

// MARK: - WeatherListPresenterOutput

extension WeatherListViewController: WeatherListPresenterOutput {

}
