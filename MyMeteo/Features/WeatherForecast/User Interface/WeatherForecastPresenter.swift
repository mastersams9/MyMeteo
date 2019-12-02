//
//  WeatherForecastPresenter.swift
//  MyMeteo
//
//  Rahim template version 1.0
//
//  Created by Sami Benmakhlouf on 02/12/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import UIKit

final class WeatherForecastPresenter {
    
    // MARK: - Property
    
    weak var output: WeatherForecastPresenterOutput?
    private var interactor: WeatherForecastInteractorInput
    
    // MARK: - Lifecycle
    
    init(interactor: WeatherForecastInteractorInput) {
        self.interactor = interactor
    }
    
    // MARK: - Converting
    
    private func convertToDisplayableTemperatureUnit(itemUnit: WeatherForecastInteractorItemUnit) -> String {
        switch itemUnit {
        case .celsius:
            return "°C"
        default:
            return "°F"
        }
    }
}

// MARK: - WeatherForecastPresenterInput

extension WeatherForecastPresenter: WeatherForecastPresenterInput {
    func viewDidLoad() {
        interactor.retrieve()
    }
    
    func viewModelForRowAtIndexPath(_ indexPath: IndexPath) -> WeatherForecastPresenterViewModelProtocol
    {
        var weatherMinTemperatureAttr: NSAttributedString?
        var weatherMaxTemperatureAttr: NSAttributedString?
        
        var weatherIconImageURL: URL?
        
        if let item = interactor.item(forIndex: indexPath.row, atCategoryIndex: indexPath.section)
        {
            if let weatherMinTemperature = item.weatherMinTemperature {
                weatherMinTemperatureAttr = NSAttributedString(string: "\(Int(weatherMinTemperature.rounded())) \(convertToDisplayableTemperatureUnit(itemUnit: item.temperatureUnit))")
            }
            
            if let weatherMaxTemperature = item.weatherMaxTemperature {
                weatherMaxTemperatureAttr = NSAttributedString(string: "\(Int(weatherMaxTemperature.rounded())) \(convertToDisplayableTemperatureUnit(itemUnit: item.temperatureUnit))")
            }
            
            weatherIconImageURL = item.weatherIconUrl
        }
        
        
        return WeatherForecastPresenterViewModel(weatherIconImagePlaceholder: UIImage(), weatherIconImageURL: weatherIconImageURL, weatherMinTemperature: weatherMinTemperatureAttr, weatherMaxTemperature: weatherMaxTemperatureAttr)
        
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return interactor.numberOfItemsForSection(section)
    }
}

// MARK: - WeatherForecastInteractorOutput

extension WeatherForecastPresenter: WeatherForecastInteractorOutput {
    func notifySuccess() {
        output?.reloadData()
    }
    
    func notifyUnknownError() {
        output?.displayError(AlertParams(title: "Error", message: "Unknown error occured.", buttonOkTitle: "Ok"))
    }
    
    func notifyServerError() {
        output?.displayError(AlertParams(title: "Error", message: "Server error occured.", buttonOkTitle: "Ok"))
    }
    
    func notifyNetworkError() {
        output?.displayError(AlertParams(title: "Error", message: "Network error occured.", buttonOkTitle: "Ok"))
    }
    
    func notifyEmptyListError() {
        output?.displayError(AlertParams(title: "Error", message: "Could not find any forecast.", buttonOkTitle: "Ok"))
    }
}

private struct WeatherForecastPresenterViewModel: WeatherForecastPresenterViewModelProtocol {
    var weatherIconImagePlaceholder: UIImage
    var weatherIconImageURL: URL?
    var weatherMinTemperature: NSAttributedString?
    var weatherMaxTemperature: NSAttributedString?
}

private struct AlertParams: AlertParamsProtocol {
    var title: String
    var message: String
    var buttonOkTitle: String
}
