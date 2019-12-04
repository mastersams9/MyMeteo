//
//  WeatherListRouter.swift
//  MyMeteo
//
//  Created by Sami Benmakhlouf on 30/11/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import UIKit

open class WeatherListRouter {

  // MARK: - Property

  public weak var viewController: UIViewController?

  // MARK: - Lifecycle

  public init() { }
}

// MARK: - WeatherListRouterInput

extension WeatherListRouter: WeatherListRouterInput {
    public func routeToDetails(withCity city: String) {
        if let vc = WeatherDetailsModuleFactory().makeView(withCity: city) {
            self.viewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
