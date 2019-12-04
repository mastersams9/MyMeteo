//
//  WeatherForecastPresenter.swift
//  MyMeteo
//
//
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
        var weatherMinMaxTemperatureAttr: NSAttributedString?

        var dateAttr: NSAttributedString?
        
        var weatherIconImageURL: URL?
        
        if let item = interactor.item(forIndex: indexPath.row, atCategoryIndex: indexPath.section)
        {
            var weatherMinTemperatureString = ""
            var weatherMaxTemperatureString = ""
            if let weatherMinTemperature = item.weatherMinTemperature {
                weatherMinTemperatureString = "\(Int(weatherMinTemperature.rounded()))"
            }
            if let weatherMaxTemperature = item.weatherMaxTemperature {
                weatherMaxTemperatureString = "\(Int(weatherMaxTemperature.rounded()))"
            }
            weatherMinMaxTemperatureAttr = NSAttributedString(string: "min:\(weatherMinTemperatureString) max:\(weatherMaxTemperatureString)")

            weatherIconImageURL = item.weatherIconUrl
            
            dateAttr = NSAttributedString(string: item.date ?? "")
        }
        
        
        return WeatherForecastPresenterViewModel(weatherIconImagePlaceholder: UIImage(), weatherIconImageURL: weatherIconImageURL, weatherMinMaxTemperature: weatherMinMaxTemperatureAttr, date: dateAttr)
        
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
    var weatherMinMaxTemperature: NSAttributedString?
    var date: NSAttributedString?
}

private struct AlertParams: AlertParamsProtocol {
    var title: String
    var message: String
    var buttonOkTitle: String
}
