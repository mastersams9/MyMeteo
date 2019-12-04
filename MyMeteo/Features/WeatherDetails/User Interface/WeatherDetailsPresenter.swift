//
//  WeatherDetailsPresenter.swift
//  MyMeteo
//
//  Created by Sami Benmakhlouf on 30/11/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import UIKit

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
    private func convertToDisplayableTemperatureUnit(itemUnit: WeatherDetailsInteractorItemUnit) -> String {
        switch itemUnit {
        case .celsius:
            return "°C"
        default:
            return "°F"
        }
    }
}

// MARK: - WeatherDetailsPresenterInput

extension WeatherDetailsPresenter: WeatherDetailsPresenterInput {
    func viewDidLoad() {
        interactor.prepare()
        interactor.retrieve()
    }
}

// MARK: - WeatherDetailsInteractorOutput

extension WeatherDetailsPresenter: WeatherDetailsInteractorOutput {
    func updateCategories(cityName: String) {
        output?.displayViewCategories(cityName: cityName)
    }
    
    func notifySuccess(item: WeatherDetailsInteractorItemProtocol) {
        var weatherDescriptionAttr: NSAttributedString?
        var weatherCurrentTemperatureAttr: NSAttributedString?
        var nameAttr: NSAttributedString?

        var weatherIconImageURL: URL?
        
        nameAttr = NSAttributedString(string: item.name)
        if let weatherDescription = item.weatherDescription {
            weatherDescriptionAttr = NSAttributedString(string: weatherDescription.capitalized)
        }
        if let weatherCurrentTemperature = item.weatherCurrentTemperature {
            weatherCurrentTemperatureAttr = NSAttributedString(string: "\(Int(weatherCurrentTemperature.rounded())) \(convertToDisplayableTemperatureUnit(itemUnit: item.temperatureUnit))")
        }

        weatherIconImageURL = item.weatherIconUrl
        
        output?.updateView(viewModel: WeatherDetailsPresenterViewModel(name: nameAttr ?? NSAttributedString(string: ""), weatherIconImagePlaceholder: UIImage(), weatherIconImageURL: weatherIconImageURL, weatherDescription: weatherDescriptionAttr, weatherCurrentTemperature: weatherCurrentTemperatureAttr))
         
    }
    
    func notifyServerError() {
        output?.displayError(AlertParams(title: "Error", message: "Server error occured.", buttonOkTitle: "Ok"))
    }
    
}

private struct WeatherDetailsPresenterViewModel: WeatherDetailsPresenterViewModelProtocol {
    var name: NSAttributedString
    var weatherIconImagePlaceholder: UIImage
    var weatherIconImageURL: URL?
    var weatherDescription: NSAttributedString?
    var weatherCurrentTemperature: NSAttributedString?
}

private struct AlertParams: AlertParamsProtocol {
    var title: String
    var message: String
    var buttonOkTitle: String
}
