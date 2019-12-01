//
//  WeatherListPresenter.swift
//  MyMeteo
//
//  Created by Sami Benmakhlouf on 30/11/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import UIKit

final class WeatherListPresenter {

    // MARK: - Constants

    private enum Constants {
        static let defaultImage = UIImage()
        static let defaultValue = ""
        static let defaultName = NSAttributedString(string: "")
    }

    // MARK: - Property

    weak var output: WeatherListPresenterOutput?
    private var interactor: WeatherListInteractorInput
    private var router: WeatherListRouterInput

    // MARK: - Lifecycle

    init(interactor: WeatherListInteractorInput, router: WeatherListRouterInput) {
        self.interactor = interactor
        self.router = router
    }

    // MARK: - Converting

    private func convertToDisplayableTemperatureUnit(itemUnit: WeatherListInteractorItemUnit) -> String {
        switch itemUnit {
        case .celsius:
            return "°C"
        default:
            return "°F"
        }
    }

}

// MARK: - WeatherListPresenterInput

extension WeatherListPresenter: WeatherListPresenterInput {
    func viewDidLoad() {
        interactor.retrieve()
    }

    func numberOfSections() -> Int {
        return interactor.numberOfCategories()
    }

    func numberOfRowsInSection(_ section: Int) -> Int {
        return interactor.numberOfItemsForCategoryIndex(section)
    }

    func viewModelForRowAtIndexPath(_ indexPath: IndexPath) -> WeatherListPresenterViewModelProtocol {

        var weatherDescriptionAttr: NSAttributedString?
        var weatherCurrentTemperatureAttr: NSAttributedString?
        var weatherMinMaxTemperatureAttr: NSAttributedString?
        var nameAttr: NSAttributedString?

        var weatherIconImageURL: URL?

        if let item = interactor.item(forIndex: indexPath.row, atCategoryIndex: indexPath.section) {
            nameAttr = NSAttributedString(string: item.name)
            if let weatherDescription = item.weatherDescription {
                weatherDescriptionAttr = NSAttributedString(string: weatherDescription.capitalized)
            }
            if let weatherCurrentTemperature = item.weatherCurrentTemperature {
                weatherCurrentTemperatureAttr = NSAttributedString(string: "\(Int(weatherCurrentTemperature.rounded())) \(convertToDisplayableTemperatureUnit(itemUnit: item.temperatureUnit))")
            }
            var weatherMinTemperatureString = Constants.defaultValue
            var weatherMaxTemperatureString = Constants.defaultValue
            if let weatherMinTemperature = item.weatherMinTemperature {
                weatherMinTemperatureString = "\(Int(weatherMinTemperature.rounded()))"
            }
            if let weatherMaxTemperature = item.weatherMaxTemperature {
                weatherMaxTemperatureString = "\(Int(weatherMaxTemperature.rounded()))"
            }
            weatherMinMaxTemperatureAttr = NSAttributedString(string: "\(weatherMinTemperatureString)\t\(weatherMaxTemperatureString)")

            weatherIconImageURL = item.weatherIconUrl
        }
        return WeatherListPresenterViewModel(name: nameAttr ?? Constants.defaultName,
                                             weatherIconImagePlaceholder: Constants.defaultImage,
                                             weatherIconImageURL: weatherIconImageURL,
                                             weatherDescription: weatherDescriptionAttr,
                                             weatherCurrentTemperature: weatherCurrentTemperatureAttr,
                                             weatherMinMaxTemperature: weatherMinMaxTemperatureAttr)
    }

    func prefetchRowsAtIndexPaths(_ indexPaths: [IndexPath]?) {
        interactor.preloadItems(at: indexPaths?.map { $0.row })
    }

    func cancelPrefetchingForRowsAt(_ indexPaths: [IndexPath]?) {
        interactor.cancelItems(at: indexPaths?.map { $0.row })
    }
}

// MARK: - WeatherListInteractorOutput

extension WeatherListPresenter: WeatherListInteractorOutput {

    func setDefaultValues() {
        output?.displayTitle("France Cities Weather Info")
    }
    
    func notifyLoading() {
        output?.showLoader()
    }

    func updateItems() {
        output?.hideLoader()
        output?.reloadData()
    }

    func notifyFranceCitiesListNotFoundError() {
        output?.hideLoader()
        output?.displayError(AlertParams(title: "Error", message: "No France Cities Found.", buttonOkTitle: "Ok"))
    }

    func notifyFranceCitiesEmptyListError() {
        output?.hideLoader()
        output?.displayError(AlertParams(title: "Error", message: "Empty France Cities Found.", buttonOkTitle: "Ok"))
    }

    func updateItem(atIndex index: Int, forCategoryIndex categoryIndex: Int) {
        output?.reloadRows([IndexPath(row: index, section: categoryIndex)])
    }
}

// MARK: - Privates

private struct WeatherListPresenterViewModel: WeatherListPresenterViewModelProtocol {
    var name: NSAttributedString
    var weatherIconImagePlaceholder: UIImage
    var weatherIconImageURL: URL?
    var weatherDescription: NSAttributedString?
    var weatherCurrentTemperature: NSAttributedString?
    var weatherMinMaxTemperature: NSAttributedString?
}

private struct AlertParams: AlertParamsProtocol {
    var title: String
    var message: String
    var buttonOkTitle: String
}
