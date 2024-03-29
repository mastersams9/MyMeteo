// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

@testable import MyMeteo














class FileReaderProtocolMock: FileReaderProtocol {

    //MARK: - read

    var readFromCallsCount = 0
    var readFromCalled: Bool {
        return readFromCallsCount > 0
    }
    var readFromReceivedName: String?
    var readFromReceivedInvocations: [String] = []
    var readFromReturnValue: Data?
    var readFromClosure: ((String) -> Data?)?

    func read(from name: String) -> Data? {
        readFromCallsCount += 1
        readFromReceivedName = name
        readFromReceivedInvocations.append(name)
        return readFromClosure.map({ $0(name) }) ?? readFromReturnValue
    }

}
class FranceCitiesRepositoryProtocolMock: FranceCitiesRepositoryProtocol {

    //MARK: - fetch

    var fetchSuccessFailureCallsCount = 0
    var fetchSuccessFailureCalled: Bool {
        return fetchSuccessFailureCallsCount > 0
    }
    var fetchSuccessFailureReceivedArguments: (success: ([FranceCitiesRepositoryResponseProtocol]) -> Void, failure: (FranceCitiesRepositoryError) -> Void)?
    var fetchSuccessFailureReceivedInvocations: [(success: ([FranceCitiesRepositoryResponseProtocol]) -> Void, failure: (FranceCitiesRepositoryError) -> Void)] = []
    var fetchSuccessFailureClosure: ((@escaping ([FranceCitiesRepositoryResponseProtocol]) -> Void, @escaping (FranceCitiesRepositoryError) -> Void) -> Void)?

    func fetch(success: @escaping ([FranceCitiesRepositoryResponseProtocol]) -> Void,               failure: @escaping (FranceCitiesRepositoryError) -> Void) {
        fetchSuccessFailureCallsCount += 1
        fetchSuccessFailureReceivedArguments = (success: success, failure: failure)
        fetchSuccessFailureReceivedInvocations.append((success: success, failure: failure))
        fetchSuccessFailureClosure?(success, failure)
    }

}
class FranceCitiesRepositoryResponseProtocolMock: FranceCitiesRepositoryResponseProtocol {
    var id: String?
    var name: String?

}
class ImageLoaderMock: ImageLoader {

    //MARK: - loadImage

    var loadImageImageViewUrlCallsCount = 0
    var loadImageImageViewUrlCalled: Bool {
        return loadImageImageViewUrlCallsCount > 0
    }
    var loadImageImageViewUrlReceivedArguments: (imageView: UIImageView, url: URL?)?
    var loadImageImageViewUrlReceivedInvocations: [(imageView: UIImageView, url: URL?)] = []
    var loadImageImageViewUrlClosure: ((UIImageView, URL?) -> Void)?

    func loadImage(imageView: UIImageView, url: URL?) {
        loadImageImageViewUrlCallsCount += 1
        loadImageImageViewUrlReceivedArguments = (imageView: imageView, url: url)
        loadImageImageViewUrlReceivedInvocations.append((imageView: imageView, url: url))
        loadImageImageViewUrlClosure?(imageView, url)
    }

    //MARK: - loadImage

    var loadImageImageViewUrlPlaceholderCallsCount = 0
    var loadImageImageViewUrlPlaceholderCalled: Bool {
        return loadImageImageViewUrlPlaceholderCallsCount > 0
    }
    var loadImageImageViewUrlPlaceholderReceivedArguments: (imageView: UIImageView, url: URL?, placeholder: UIImage?)?
    var loadImageImageViewUrlPlaceholderReceivedInvocations: [(imageView: UIImageView, url: URL?, placeholder: UIImage?)] = []
    var loadImageImageViewUrlPlaceholderClosure: ((UIImageView, URL?, UIImage?) -> Void)?

    func loadImage(imageView: UIImageView, url: URL?, placeholder: UIImage?) {
        loadImageImageViewUrlPlaceholderCallsCount += 1
        loadImageImageViewUrlPlaceholderReceivedArguments = (imageView: imageView, url: url, placeholder: placeholder)
        loadImageImageViewUrlPlaceholderReceivedInvocations.append((imageView: imageView, url: url, placeholder: placeholder))
        loadImageImageViewUrlPlaceholderClosure?(imageView, url, placeholder)
    }

    //MARK: - loadImage

    var loadImageImageViewUrlPlaceholderAnimatedCallsCount = 0
    var loadImageImageViewUrlPlaceholderAnimatedCalled: Bool {
        return loadImageImageViewUrlPlaceholderAnimatedCallsCount > 0
    }
    var loadImageImageViewUrlPlaceholderAnimatedReceivedArguments: (imageView: UIImageView, url: URL?, placeholder: UIImage?, animated: Bool)?
    var loadImageImageViewUrlPlaceholderAnimatedReceivedInvocations: [(imageView: UIImageView, url: URL?, placeholder: UIImage?, animated: Bool)] = []
    var loadImageImageViewUrlPlaceholderAnimatedClosure: ((UIImageView, URL?, UIImage?, Bool) -> Void)?

    func loadImage(imageView: UIImageView, url: URL?, placeholder: UIImage?, animated: Bool) {
        loadImageImageViewUrlPlaceholderAnimatedCallsCount += 1
        loadImageImageViewUrlPlaceholderAnimatedReceivedArguments = (imageView: imageView, url: url, placeholder: placeholder, animated: animated)
        loadImageImageViewUrlPlaceholderAnimatedReceivedInvocations.append((imageView: imageView, url: url, placeholder: placeholder, animated: animated))
        loadImageImageViewUrlPlaceholderAnimatedClosure?(imageView, url, placeholder, animated)
    }

}
class WeatherAPICityInfoResponseProtocolMock: WeatherAPICityInfoResponseProtocol {
    var id: Int?
    var name: String?
    var weather: WeatherAPIWeatherResponseProtocol?
    var main: WeatherAPIMainResponseProtocol?
    var wind: WeatherAPIWindResponseProtocol?

}
class WeatherAPIForecastResponseProtocolMock: WeatherAPIForecastResponseProtocol {
    var weatherTemperature: Double?
    var iconUrl: URL?
    var date: String?

}
class WeatherAPIMainResponseProtocolMock: WeatherAPIMainResponseProtocol {
    var temp: Double?
    var pressure: Double?
    var humidity: Int?
    var tempMin: Double?
    var tempMax: Double?

}
class WeatherAPIRepositoryInputMock: WeatherAPIRepositoryInput {

    //MARK: - getWeatherInfo

    var getWeatherInfoForCityWithUnitSuccessFailureCallsCount = 0
    var getWeatherInfoForCityWithUnitSuccessFailureCalled: Bool {
        return getWeatherInfoForCityWithUnitSuccessFailureCallsCount > 0
    }
    var getWeatherInfoForCityWithUnitSuccessFailureReceivedArguments: (city: String, unit: WeatherAPIRepositoryUnit, success: (WeatherAPICityInfoResponseProtocol) -> Void, failure: ((WeatherAPIRepositoryError, String) -> Void)?)?
    var getWeatherInfoForCityWithUnitSuccessFailureReceivedInvocations: [(city: String, unit: WeatherAPIRepositoryUnit, success: (WeatherAPICityInfoResponseProtocol) -> Void, failure: ((WeatherAPIRepositoryError, String) -> Void)?)] = []
    var getWeatherInfoForCityWithUnitSuccessFailureClosure: ((String, WeatherAPIRepositoryUnit, @escaping (WeatherAPICityInfoResponseProtocol) -> Void, ((WeatherAPIRepositoryError, String) -> Void)?) -> Void)?

    func getWeatherInfo(forCity city: String, withUnit unit: WeatherAPIRepositoryUnit, success: @escaping (WeatherAPICityInfoResponseProtocol) -> Void, failure: ((WeatherAPIRepositoryError, String) -> Void)?) {
        getWeatherInfoForCityWithUnitSuccessFailureCallsCount += 1
        getWeatherInfoForCityWithUnitSuccessFailureReceivedArguments = (city: city, unit: unit, success: success, failure: failure)
        getWeatherInfoForCityWithUnitSuccessFailureReceivedInvocations.append((city: city, unit: unit, success: success, failure: failure))
        getWeatherInfoForCityWithUnitSuccessFailureClosure?(city, unit, success, failure)
    }

    //MARK: - getWeatherForecastInfo

    var getWeatherForecastInfoForCityWithUnitSuccessFailureCallsCount = 0
    var getWeatherForecastInfoForCityWithUnitSuccessFailureCalled: Bool {
        return getWeatherForecastInfoForCityWithUnitSuccessFailureCallsCount > 0
    }
    var getWeatherForecastInfoForCityWithUnitSuccessFailureReceivedArguments: (city: String, unit: WeatherAPIRepositoryUnit, success: ([WeatherAPIForecastResponseProtocol]) -> Void, failure: ((WeatherAPIRepositoryError) -> Void)?)?
    var getWeatherForecastInfoForCityWithUnitSuccessFailureReceivedInvocations: [(city: String, unit: WeatherAPIRepositoryUnit, success: ([WeatherAPIForecastResponseProtocol]) -> Void, failure: ((WeatherAPIRepositoryError) -> Void)?)] = []
    var getWeatherForecastInfoForCityWithUnitSuccessFailureClosure: ((String, WeatherAPIRepositoryUnit, @escaping ([WeatherAPIForecastResponseProtocol]) -> Void, ((WeatherAPIRepositoryError) -> Void)?) -> Void)?

    func getWeatherForecastInfo(forCity city: String, withUnit unit: WeatherAPIRepositoryUnit, success: @escaping ([WeatherAPIForecastResponseProtocol]) -> Void, failure: ((WeatherAPIRepositoryError) -> Void)?) {
        getWeatherForecastInfoForCityWithUnitSuccessFailureCallsCount += 1
        getWeatherForecastInfoForCityWithUnitSuccessFailureReceivedArguments = (city: city, unit: unit, success: success, failure: failure)
        getWeatherForecastInfoForCityWithUnitSuccessFailureReceivedInvocations.append((city: city, unit: unit, success: success, failure: failure))
        getWeatherForecastInfoForCityWithUnitSuccessFailureClosure?(city, unit, success, failure)
    }

    //MARK: - cancel

    var cancelForCityWithUnitCallsCount = 0
    var cancelForCityWithUnitCalled: Bool {
        return cancelForCityWithUnitCallsCount > 0
    }
    var cancelForCityWithUnitReceivedArguments: (city: String, unit: WeatherAPIRepositoryUnit)?
    var cancelForCityWithUnitReceivedInvocations: [(city: String, unit: WeatherAPIRepositoryUnit)] = []
    var cancelForCityWithUnitClosure: ((String, WeatherAPIRepositoryUnit) -> Void)?

    func cancel(forCity city: String, withUnit unit: WeatherAPIRepositoryUnit) {
        cancelForCityWithUnitCallsCount += 1
        cancelForCityWithUnitReceivedArguments = (city: city, unit: unit)
        cancelForCityWithUnitReceivedInvocations.append((city: city, unit: unit))
        cancelForCityWithUnitClosure?(city, unit)
    }

}
class WeatherAPIWeatherResponseProtocolMock: WeatherAPIWeatherResponseProtocol {
    var id: Int?
    var main: String?
    var description: String?
    var iconUrl: URL?

}
class WeatherAPIWindResponseProtocolMock: WeatherAPIWindResponseProtocol {
    var speed: Double?
    var deg: Double?

}
class WeatherDetailsInteractorOutputMock: WeatherDetailsInteractorOutput {

    //MARK: - updateCategories

    var updateCategoriesCityNameCallsCount = 0
    var updateCategoriesCityNameCalled: Bool {
        return updateCategoriesCityNameCallsCount > 0
    }
    var updateCategoriesCityNameReceivedCityName: String?
    var updateCategoriesCityNameReceivedInvocations: [String] = []
    var updateCategoriesCityNameClosure: ((String) -> Void)?

    func updateCategories(cityName: String) {
        updateCategoriesCityNameCallsCount += 1
        updateCategoriesCityNameReceivedCityName = cityName
        updateCategoriesCityNameReceivedInvocations.append(cityName)
        updateCategoriesCityNameClosure?(cityName)
    }

    //MARK: - notifySuccess

    var notifySuccessItemCallsCount = 0
    var notifySuccessItemCalled: Bool {
        return notifySuccessItemCallsCount > 0
    }
    var notifySuccessItemReceivedItem: WeatherDetailsInteractorItemProtocol?
    var notifySuccessItemReceivedInvocations: [WeatherDetailsInteractorItemProtocol] = []
    var notifySuccessItemClosure: ((WeatherDetailsInteractorItemProtocol) -> Void)?

    func notifySuccess(item: WeatherDetailsInteractorItemProtocol) {
        notifySuccessItemCallsCount += 1
        notifySuccessItemReceivedItem = item
        notifySuccessItemReceivedInvocations.append(item)
        notifySuccessItemClosure?(item)
    }

    //MARK: - notifyServerError

    var notifyServerErrorCallsCount = 0
    var notifyServerErrorCalled: Bool {
        return notifyServerErrorCallsCount > 0
    }
    var notifyServerErrorClosure: (() -> Void)?

    func notifyServerError() {
        notifyServerErrorCallsCount += 1
        notifyServerErrorClosure?()
    }

}
class WeatherForecastInteractorInputMock: WeatherForecastInteractorInput {
    var output: WeatherForecastInteractorOutput?

    //MARK: - retrieve

    var retrieveCallsCount = 0
    var retrieveCalled: Bool {
        return retrieveCallsCount > 0
    }
    var retrieveClosure: (() -> Void)?

    func retrieve() {
        retrieveCallsCount += 1
        retrieveClosure?()
    }

    //MARK: - numberOfItemsForSection

    var numberOfItemsForSectionCallsCount = 0
    var numberOfItemsForSectionCalled: Bool {
        return numberOfItemsForSectionCallsCount > 0
    }
    var numberOfItemsForSectionReceivedSection: Int?
    var numberOfItemsForSectionReceivedInvocations: [Int] = []
    var numberOfItemsForSectionReturnValue: Int!
    var numberOfItemsForSectionClosure: ((Int) -> Int)?

    func numberOfItemsForSection(_ section: Int) -> Int {
        numberOfItemsForSectionCallsCount += 1
        numberOfItemsForSectionReceivedSection = section
        numberOfItemsForSectionReceivedInvocations.append(section)
        return numberOfItemsForSectionClosure.map({ $0(section) }) ?? numberOfItemsForSectionReturnValue
    }

    //MARK: - item

    var itemForIndexAtCategoryIndexCallsCount = 0
    var itemForIndexAtCategoryIndexCalled: Bool {
        return itemForIndexAtCategoryIndexCallsCount > 0
    }
    var itemForIndexAtCategoryIndexReceivedArguments: (index: Int, categoryIndex: Int)?
    var itemForIndexAtCategoryIndexReceivedInvocations: [(index: Int, categoryIndex: Int)] = []
    var itemForIndexAtCategoryIndexReturnValue: WeatherForecastInteractorItemProtocol?
    var itemForIndexAtCategoryIndexClosure: ((Int, Int) -> WeatherForecastInteractorItemProtocol?)?

    func item(forIndex index: Int, atCategoryIndex categoryIndex: Int) -> WeatherForecastInteractorItemProtocol? {
        itemForIndexAtCategoryIndexCallsCount += 1
        itemForIndexAtCategoryIndexReceivedArguments = (index: index, categoryIndex: categoryIndex)
        itemForIndexAtCategoryIndexReceivedInvocations.append((index: index, categoryIndex: categoryIndex))
        return itemForIndexAtCategoryIndexClosure.map({ $0(index, categoryIndex) }) ?? itemForIndexAtCategoryIndexReturnValue
    }

}
class WeatherForecastInteractorItemProtocolMock: WeatherForecastInteractorItemProtocol {
    var temperatureUnit: WeatherForecastInteractorItemUnit {
        get { return underlyingTemperatureUnit }
        set(value) { underlyingTemperatureUnit = value }
    }
    var underlyingTemperatureUnit: WeatherForecastInteractorItemUnit!
    var weatherMinTemperature: Double?
    var weatherMaxTemperature: Double?
    var weatherIconUrl: URL?
    var date: String?

}
class WeatherForecastInteractorOutputMock: WeatherForecastInteractorOutput {

    //MARK: - notifySuccess

    var notifySuccessCallsCount = 0
    var notifySuccessCalled: Bool {
        return notifySuccessCallsCount > 0
    }
    var notifySuccessClosure: (() -> Void)?

    func notifySuccess() {
        notifySuccessCallsCount += 1
        notifySuccessClosure?()
    }

    //MARK: - notifyUnknownError

    var notifyUnknownErrorCallsCount = 0
    var notifyUnknownErrorCalled: Bool {
        return notifyUnknownErrorCallsCount > 0
    }
    var notifyUnknownErrorClosure: (() -> Void)?

    func notifyUnknownError() {
        notifyUnknownErrorCallsCount += 1
        notifyUnknownErrorClosure?()
    }

    //MARK: - notifyServerError

    var notifyServerErrorCallsCount = 0
    var notifyServerErrorCalled: Bool {
        return notifyServerErrorCallsCount > 0
    }
    var notifyServerErrorClosure: (() -> Void)?

    func notifyServerError() {
        notifyServerErrorCallsCount += 1
        notifyServerErrorClosure?()
    }

    //MARK: - notifyNetworkError

    var notifyNetworkErrorCallsCount = 0
    var notifyNetworkErrorCalled: Bool {
        return notifyNetworkErrorCallsCount > 0
    }
    var notifyNetworkErrorClosure: (() -> Void)?

    func notifyNetworkError() {
        notifyNetworkErrorCallsCount += 1
        notifyNetworkErrorClosure?()
    }

    //MARK: - notifyEmptyListError

    var notifyEmptyListErrorCallsCount = 0
    var notifyEmptyListErrorCalled: Bool {
        return notifyEmptyListErrorCallsCount > 0
    }
    var notifyEmptyListErrorClosure: (() -> Void)?

    func notifyEmptyListError() {
        notifyEmptyListErrorCallsCount += 1
        notifyEmptyListErrorClosure?()
    }

}
class WeatherListInteractorOutputMock: WeatherListInteractorOutput {

    //MARK: - setDefaultValues

    var setDefaultValuesCallsCount = 0
    var setDefaultValuesCalled: Bool {
        return setDefaultValuesCallsCount > 0
    }
    var setDefaultValuesClosure: (() -> Void)?

    func setDefaultValues() {
        setDefaultValuesCallsCount += 1
        setDefaultValuesClosure?()
    }

    //MARK: - notifyLoading

    var notifyLoadingCallsCount = 0
    var notifyLoadingCalled: Bool {
        return notifyLoadingCallsCount > 0
    }
    var notifyLoadingClosure: (() -> Void)?

    func notifyLoading() {
        notifyLoadingCallsCount += 1
        notifyLoadingClosure?()
    }

    //MARK: - updateItems

    var updateItemsCallsCount = 0
    var updateItemsCalled: Bool {
        return updateItemsCallsCount > 0
    }
    var updateItemsClosure: (() -> Void)?

    func updateItems() {
        updateItemsCallsCount += 1
        updateItemsClosure?()
    }

    //MARK: - notifyFranceCitiesListNotFoundError

    var notifyFranceCitiesListNotFoundErrorCallsCount = 0
    var notifyFranceCitiesListNotFoundErrorCalled: Bool {
        return notifyFranceCitiesListNotFoundErrorCallsCount > 0
    }
    var notifyFranceCitiesListNotFoundErrorClosure: (() -> Void)?

    func notifyFranceCitiesListNotFoundError() {
        notifyFranceCitiesListNotFoundErrorCallsCount += 1
        notifyFranceCitiesListNotFoundErrorClosure?()
    }

    //MARK: - notifyFranceCitiesEmptyListError

    var notifyFranceCitiesEmptyListErrorCallsCount = 0
    var notifyFranceCitiesEmptyListErrorCalled: Bool {
        return notifyFranceCitiesEmptyListErrorCallsCount > 0
    }
    var notifyFranceCitiesEmptyListErrorClosure: (() -> Void)?

    func notifyFranceCitiesEmptyListError() {
        notifyFranceCitiesEmptyListErrorCallsCount += 1
        notifyFranceCitiesEmptyListErrorClosure?()
    }

    //MARK: - updateItem

    var updateItemAtIndexForCategoryIndexCallsCount = 0
    var updateItemAtIndexForCategoryIndexCalled: Bool {
        return updateItemAtIndexForCategoryIndexCallsCount > 0
    }
    var updateItemAtIndexForCategoryIndexReceivedArguments: (index: Int, categoryIndex: Int)?
    var updateItemAtIndexForCategoryIndexReceivedInvocations: [(index: Int, categoryIndex: Int)] = []
    var updateItemAtIndexForCategoryIndexClosure: ((Int, Int) -> Void)?

    func updateItem(atIndex index: Int, forCategoryIndex categoryIndex: Int) {
        updateItemAtIndexForCategoryIndexCallsCount += 1
        updateItemAtIndexForCategoryIndexReceivedArguments = (index: index, categoryIndex: categoryIndex)
        updateItemAtIndexForCategoryIndexReceivedInvocations.append((index: index, categoryIndex: categoryIndex))
        updateItemAtIndexForCategoryIndexClosure?(index, categoryIndex)
    }

    //MARK: - routeToDetails

    var routeToDetailsWithCityCallsCount = 0
    var routeToDetailsWithCityCalled: Bool {
        return routeToDetailsWithCityCallsCount > 0
    }
    var routeToDetailsWithCityReceivedCity: String?
    var routeToDetailsWithCityReceivedInvocations: [String] = []
    var routeToDetailsWithCityClosure: ((String) -> Void)?

    func routeToDetails(withCity city: String) {
        routeToDetailsWithCityCallsCount += 1
        routeToDetailsWithCityReceivedCity = city
        routeToDetailsWithCityReceivedInvocations.append(city)
        routeToDetailsWithCityClosure?(city)
    }

}
