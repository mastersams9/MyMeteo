//
//  WeatherDetailsViewController.swift
//  MyMeteo
//
//  Created by Sami Benmakhlouf on 30/11/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import UIKit

class WeatherDetailsViewController: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var foreCastView: UIView!
    
    // MARK: - Property
    
    var presenter: WeatherDetailsPresenterInput!
    var imageLoader: ImageLoader!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
    }
}

// MARK: - WeatherDetailsPresenterOutput

extension WeatherDetailsViewController: WeatherDetailsPresenterOutput {
    func displayViewCategories(_ categories: [CategoryView], cityName: String) {
        categories.forEach {
            switch $0 {
            case .weatherDetails:
                break
            case .weatherForecast:
                if let weatherForeCastView = WeatherForecastModuleFactory().makeView(withCityName: cityName) {
                    weatherForeCastView.viewDidLoad()
                    weatherForeCastView.frame.size.height = self.foreCastView.frame.height
                    weatherForeCastView.frame.size.width = self.foreCastView.frame.width
                    self.foreCastView.addSubview(weatherForeCastView)
                }
            }
        }
    }
    func displayError(_ params: AlertParamsProtocol) {
        presentAlertPopupWithTextfield(params.title,
        message: params.message,
        confirmationTitle: params.buttonOkTitle)
    }
    
    func updateView(viewModel: WeatherDetailsPresenterViewModelProtocol) {
        temperatureLabel.attributedText = viewModel.weatherCurrentTemperature
        cityLabel.attributedText = viewModel.name
        descriptionLabel.attributedText = viewModel.weatherDescription
        imageLoader.loadImage(imageView: imageView, url: viewModel.weatherIconImageURL, placeholder: viewModel.weatherIconImagePlaceholder)
    }
}
