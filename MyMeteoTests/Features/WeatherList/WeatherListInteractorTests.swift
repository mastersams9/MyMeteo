//
//  WeatherListInteractorTests.swift
//  MyMeteoTests
//
//  Created by Sami Benmakhlouf on 01/12/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import Nimble
import Quick
import XCTest

@testable import MyMeteo

class WeatherListInteractorTests: QuickSpec {

    // MARK: - Properties

    var output: WeatherListInteractorOutputMock!
    var franceCitiesRepository: FranceCitiesRepositoryProtocolMock!
    var weatherAPIRepository: WeatherAPIRepositoryInputMock!
    var interactor: WeatherListInteractor!


    // MARK: - Tests

    override func spec() {
        beforeEach {
            self.output = WeatherListInteractorOutputMock()
            self.franceCitiesRepository = FranceCitiesRepositoryProtocolMock()
            self.weatherAPIRepository = WeatherAPIRepositoryInputMock()
            self.interactor = WeatherListInteractor(franceCitiesRepository: self.franceCitiesRepository, weatherAPIRepository: self.weatherAPIRepository)
            self.interactor.output = self.output
        }

        describe("GIVEN I want to see weather information And have a valid list And valid weather info") {
            beforeEach {
                self.franceCitiesRepository.fetchSuccessFailureClosure = { success, _ in
                    let city1 = FranceCitiesRepositoryResponseProtocolMock()
                    city1.id = "0"
                    city1.name = "Paris"
                    let city2 = FranceCitiesRepositoryResponseProtocolMock()
                    city2.id = "1"
                    city2.name = "Marseille"
                    let city3 = FranceCitiesRepositoryResponseProtocolMock()
                    city3.id = "2"
                    city3.name = "Lyon"
                    let mocks: [FranceCitiesRepositoryResponseProtocolMock] = [city1, city2, city3]
                    success(mocks)
                }
                self.weatherAPIRepository.getWeatherInfoForCityWithUnitSuccessFailureClosure = { _, _, success, _ in
                    let response = WeatherAPICityInfoResponseProtocolMock()
                    response.id = 0
                    success(response)
                }
            }
            context("WHEN I retrieve it") {
                beforeEach {
                    self.interactor.retrieve()
                }
                it("THEN we notify loading") {
                    expect(self.output.notifyLoadingCallsCount) == 1
                }
                it("THEN we set default values") {
                    expect(self.output.setDefaultValuesCallsCount) == 1
                }
                it("THEN we need to fetch franceCitites") {
                    expect(self.franceCitiesRepository.fetchSuccessFailureCallsCount) == 1
                }
                it("THEN we do not need to call weatherRepo") {
                    expect(self.weatherAPIRepository.getWeatherInfoForCityWithUnitSuccessFailureCallsCount) == 0
                }
                it("THEN we notify updateItems") {
                    expect(self.output.updateItemsCallsCount) == 1
                }
                it("THEN we do not notify franceCitiesListNotFound error") {
                    expect(self.output.notifyFranceCitiesListNotFoundErrorCallsCount) == 0
                }
                it("THEN we do not notify franceCities empty list error") {
                    expect(self.output.notifyFranceCitiesEmptyListErrorCallsCount) == 0
                }
                it("THEN we do not need to call weatherRepo") {
                    expect(self.weatherAPIRepository.getWeatherInfoForCityWithUnitSuccessFailureCallsCount) == 0
                }
            }
        }

        describe("GIVEN I want to see weather information And have an empty list") {
            beforeEach {
                self.franceCitiesRepository.fetchSuccessFailureClosure = { success, _ in
                    let mocks: [FranceCitiesRepositoryResponseProtocolMock] = []
                    success(mocks)
                }
            }
            context("WHEN I retrieve it") {
                beforeEach {
                    self.interactor.retrieve()
                }
                it("THEN we notify loading") {
                    expect(self.output.notifyLoadingCallsCount) == 1
                }
                it("THEN we set default values") {
                    expect(self.output.setDefaultValuesCallsCount) == 1
                }
                it("THEN we need to fetch franceCitites") {
                    expect(self.franceCitiesRepository.fetchSuccessFailureCallsCount) == 1
                }
                it("THEN we do not need to call weatherRepo") {
                    expect(self.weatherAPIRepository.getWeatherInfoForCityWithUnitSuccessFailureCallsCount) == 0
                }
                it("THEN we do not notify updateItems") {
                    expect(self.output.updateItemsCallsCount) == 0
                }
                it("THEN we do not notify franceCitiesListNotFound error") {
                    expect(self.output.notifyFranceCitiesListNotFoundErrorCallsCount) == 0
                }
                it("THEN we notify franceCities empty list error") {
                    expect(self.output.notifyFranceCitiesEmptyListErrorCallsCount) == 1
                }
            }
        }

        describe("GIVEN I want to see weather information And have a invalid list") {
            beforeEach {
                self.franceCitiesRepository.fetchSuccessFailureClosure = { _, failure in
                    failure(.unknown)
                }
            }
            context("WHEN I retrieve it") {
                beforeEach {
                    self.interactor.retrieve()
                }
                it("THEN we notify loading") {
                    expect(self.output.notifyLoadingCallsCount) == 1
                }
                it("THEN we set default values") {
                    expect(self.output.setDefaultValuesCallsCount) == 1
                }
                it("THEN we need to fetch franceCitites") {
                    expect(self.franceCitiesRepository.fetchSuccessFailureCallsCount) == 1
                }
                it("THEN we do not need to call weatherRepo") {
                    expect(self.weatherAPIRepository.getWeatherInfoForCityWithUnitSuccessFailureCallsCount) == 0
                }
                it("THEN we do not notify updateItems") {
                    expect(self.output.updateItemsCallsCount) == 0
                }
                it("THEN we notify franceCitiesListNotFound error") {
                    expect(self.output.notifyFranceCitiesListNotFoundErrorCallsCount) == 1
                }
                it("THEN we do not notify franceCities empty list error") {
                    expect(self.output.notifyFranceCitiesEmptyListErrorCallsCount) == 0
                }
            }
        }

        describe("GIVEN I already retrieved valid list wih 1 item") {
            beforeEach {
                self.franceCitiesRepository.fetchSuccessFailureClosure = { success, _ in
                    let city1 = FranceCitiesRepositoryResponseProtocolMock()
                    city1.id = "0"
                    city1.name = "Lille"
                    let mocks: [FranceCitiesRepositoryResponseProtocolMock] = [city1]
                    success(mocks)
                }
                self.weatherAPIRepository.getWeatherInfoForCityWithUnitSuccessFailureClosure = { _, _, success, _ in
                    let response = WeatherAPICityInfoResponseProtocolMock()
                    response.id = 0
                    success(response)
                }
                self.interactor.retrieve()
            }
            context("WHEN I retrieve the number of categories") {
                var numberOfCategories: Int? = nil
                beforeEach {
                    numberOfCategories = self.interactor.numberOfCategories()
                }
                it("THEN we notify loading") {
                    expect(self.output.notifyLoadingCallsCount) == 1
                }
                it("THEN we set default values") {
                    expect(self.output.setDefaultValuesCallsCount) == 1
                }
                it("THEN we need to fetch franceCitites") {
                    expect(self.franceCitiesRepository.fetchSuccessFailureCallsCount) == 1
                }
                it("THEN we do not need to call weatherRepo") {
                    expect(self.weatherAPIRepository.getWeatherInfoForCityWithUnitSuccessFailureCallsCount) == 0
                }
                it("THEN we notify updateItems") {
                    expect(self.output.updateItemsCallsCount) == 1
                }
                it("THEN we do not notify franceCitiesListNotFound error") {
                    expect(self.output.notifyFranceCitiesListNotFoundErrorCallsCount) == 0
                }
                it("THEN we do not notify franceCities empty list error") {
                    expect(self.output.notifyFranceCitiesEmptyListErrorCallsCount) == 0
                }
                it("THEN numberOfCategories must be equal to 1") {
                    expect(numberOfCategories) == 1
                }
            }

            context("WHEN I retrieve the number of items for category 0") {
                var numberOfItems: Int? = nil
                beforeEach {
                    numberOfItems = self.interactor.numberOfItemsForCategoryIndex(0)
                }
                it("THEN we notify loading") {
                    expect(self.output.notifyLoadingCallsCount) == 1
                }
                it("THEN we set default values") {
                    expect(self.output.setDefaultValuesCallsCount) == 1
                }
                it("THEN we need to fetch franceCitites") {
                    expect(self.franceCitiesRepository.fetchSuccessFailureCallsCount) == 1
                }
                it("THEN we do not need to call weatherRepo") {
                    expect(self.weatherAPIRepository.getWeatherInfoForCityWithUnitSuccessFailureCallsCount) == 0
                }
                it("THEN we notify updateItems") {
                    expect(self.output.updateItemsCallsCount) == 1
                }
                it("THEN we do not notify franceCitiesListNotFound error") {
                    expect(self.output.notifyFranceCitiesListNotFoundErrorCallsCount) == 0
                }
                it("THEN we do not notify franceCities empty list error") {
                    expect(self.output.notifyFranceCitiesEmptyListErrorCallsCount) == 0
                }
                it("THEN numberOfItems must be equal to 1") {
                    expect(numberOfItems) == 1
                }
            }

            context("WHEN I retrieve item for category 0 and index 0") {
                var item: WeatherListInteractorItemProtocol? = nil
                beforeEach {
                    item = self.interactor.item(forIndex: 0, atCategoryIndex: 0)
                }
                it("THEN we notify loading") {
                    expect(self.output.notifyLoadingCallsCount) == 1
                }
                it("THEN we set default values") {
                    expect(self.output.setDefaultValuesCallsCount) == 1
                }
                it("THEN we need to fetch franceCitites") {
                    expect(self.franceCitiesRepository.fetchSuccessFailureCallsCount) == 1
                }
                it("THEN we do not need to call weatherRepo") {
                    expect(self.weatherAPIRepository.getWeatherInfoForCityWithUnitSuccessFailureCallsCount) == 0
                }
                it("THEN we notify updateItems") {
                    expect(self.output.updateItemsCallsCount) == 1
                }
                it("THEN we do not notify franceCitiesListNotFound error") {
                    expect(self.output.notifyFranceCitiesListNotFoundErrorCallsCount) == 0
                }
                it("THEN we do not notify franceCities empty list error") {
                    expect(self.output.notifyFranceCitiesEmptyListErrorCallsCount) == 0
                }
                it("THEN Item must be valid") {
                    expect(item).toNot(beNil())
                    expect(item?.name) == "Lille"
                    expect(item?.weatherIconUrl).to(beNil())
                    expect(item?.weatherDescription).to(beNil())
                    expect(item?.weatherCurrentTemperature).to(beNil())
                    expect(item?.weatherMinTemperature).to(beNil())
                    expect(item?.weatherMaxTemperature).to(beNil())
                }
            }

            context("WHEN I retrieve item for category 42 and index 0") {
                var item: WeatherListInteractorItemProtocol? = nil
                beforeEach {
                    item = self.interactor.item(forIndex: 0, atCategoryIndex: 42)
                }
                it("THEN we notify loading") {
                    expect(self.output.notifyLoadingCallsCount) == 1
                }
                it("THEN we set default values") {
                    expect(self.output.setDefaultValuesCallsCount) == 1
                }
                it("THEN we need to fetch franceCitites") {
                    expect(self.franceCitiesRepository.fetchSuccessFailureCallsCount) == 1
                }
                it("THEN we do not need to call weatherRepo") {
                    expect(self.weatherAPIRepository.getWeatherInfoForCityWithUnitSuccessFailureCallsCount) == 0
                }
                it("THEN we notify updateItems") {
                    expect(self.output.updateItemsCallsCount) == 1
                }
                it("THEN we do not notify franceCitiesListNotFound error") {
                    expect(self.output.notifyFranceCitiesListNotFoundErrorCallsCount) == 0
                }
                it("THEN we do not notify franceCities empty list error") {
                    expect(self.output.notifyFranceCitiesEmptyListErrorCallsCount) == 0
                }
                it("THEN Item must be nil") {
                    expect(item).to(beNil())
                }
            }

        }

        describe("GIVEN I already retrieved valid list wih 3 items") {
            beforeEach {
                self.franceCitiesRepository.fetchSuccessFailureClosure = { success, _ in
                    let city1 = FranceCitiesRepositoryResponseProtocolMock()
                    city1.id = "0"
                    city1.name = "Paris"
                    let city2 = FranceCitiesRepositoryResponseProtocolMock()
                    city2.id = "1"
                    city2.name = "Marseille"
                    let city3 = FranceCitiesRepositoryResponseProtocolMock()
                    let mocks: [FranceCitiesRepositoryResponseProtocolMock] = [city1, city2, city3]
                    success(mocks)
                }
                self.interactor.retrieve()
            }
            context("WHEN I retrieve the number of categories") {
                var numberOfCategories: Int? = nil
                beforeEach {
                    numberOfCategories = self.interactor.numberOfCategories()
                }
                it("THEN we notify loading") {
                    expect(self.output.notifyLoadingCallsCount) == 1
                }
                it("THEN we set default values") {
                    expect(self.output.setDefaultValuesCallsCount) == 1
                }
                it("THEN we need to fetch franceCitites") {
                    expect(self.franceCitiesRepository.fetchSuccessFailureCallsCount) == 1
                }
                it("THEN we do not need to call weatherRepo") {
                    expect(self.weatherAPIRepository.getWeatherInfoForCityWithUnitSuccessFailureCallsCount) == 0
                }
                it("THEN we notify updateItems") {
                    expect(self.output.updateItemsCallsCount) == 1
                }
                it("THEN we do not notify franceCitiesListNotFound error") {
                    expect(self.output.notifyFranceCitiesListNotFoundErrorCallsCount) == 0
                }
                it("THEN we do not notify franceCities empty list error") {
                    expect(self.output.notifyFranceCitiesEmptyListErrorCallsCount) == 0
                }
                it("THEN numberOfCategories must be equal to 1") {
                    expect(numberOfCategories) == 1
                }
            }

            context("WHEN I retrieve the number of items for category 0") {
                var numberOfItems: Int? = nil
                beforeEach {
                    numberOfItems = self.interactor.numberOfItemsForCategoryIndex(0)
                }
                it("THEN we notify loading") {
                    expect(self.output.notifyLoadingCallsCount) == 1
                }
                it("THEN we set default values") {
                    expect(self.output.setDefaultValuesCallsCount) == 1
                }
                it("THEN we need to fetch franceCitites") {
                    expect(self.franceCitiesRepository.fetchSuccessFailureCallsCount) == 1
                }
                it("THEN we do not need to call weatherRepo") {
                    expect(self.weatherAPIRepository.getWeatherInfoForCityWithUnitSuccessFailureCallsCount) == 0
                }
                it("THEN we notify updateItems") {
                    expect(self.output.updateItemsCallsCount) == 1
                }
                it("THEN we do not notify franceCitiesListNotFound error") {
                    expect(self.output.notifyFranceCitiesListNotFoundErrorCallsCount) == 0
                }
                it("THEN we do not notify franceCities empty list error") {
                    expect(self.output.notifyFranceCitiesEmptyListErrorCallsCount) == 0
                }
                it("THEN numberOfItems must be equal to 2") {
                    expect(numberOfItems) == 2
                }
            }

            context("WHEN I retrieve item for category 0 and index 0") {
                var item: WeatherListInteractorItemProtocol? = nil
                beforeEach {
                    item = self.interactor.item(forIndex: 0, atCategoryIndex: 0)
                }
                it("THEN we notify loading") {
                    expect(self.output.notifyLoadingCallsCount) == 1
                }
                it("THEN we set default values") {
                    expect(self.output.setDefaultValuesCallsCount) == 1
                }
                it("THEN we need to fetch franceCitites") {
                    expect(self.franceCitiesRepository.fetchSuccessFailureCallsCount) == 1
                }
                it("THEN we do not need to call weatherRepo") {
                    expect(self.weatherAPIRepository.getWeatherInfoForCityWithUnitSuccessFailureCallsCount) == 0
                }
                it("THEN we notify updateItems") {
                    expect(self.output.updateItemsCallsCount) == 1
                }
                it("THEN we do not notify franceCitiesListNotFound error") {
                    expect(self.output.notifyFranceCitiesListNotFoundErrorCallsCount) == 0
                }
                it("THEN we do not notify franceCities empty list error") {
                    expect(self.output.notifyFranceCitiesEmptyListErrorCallsCount) == 0
                }
                it("THEN Item must be valid") {
                    expect(item).toNot(beNil())
                    expect(item?.name) == "Paris"
                    expect(item?.weatherIconUrl).to(beNil())
                    expect(item?.weatherDescription).to(beNil())
                    expect(item?.weatherCurrentTemperature).to(beNil())
                    expect(item?.weatherMinTemperature).to(beNil())
                    expect(item?.weatherMaxTemperature).to(beNil())
                }
            }

            context("WHEN I retrieve item for category 42 and index 0") {
                var item: WeatherListInteractorItemProtocol? = nil
                beforeEach {
                    item = self.interactor.item(forIndex: 0, atCategoryIndex: 42)
                }
                it("THEN we notify loading") {
                    expect(self.output.notifyLoadingCallsCount) == 1
                }
                it("THEN we set default values") {
                    expect(self.output.setDefaultValuesCallsCount) == 1
                }
                it("THEN we need to fetch franceCitites") {
                    expect(self.franceCitiesRepository.fetchSuccessFailureCallsCount) == 1
                }
                it("THEN we do not need to call weatherRepo") {
                    expect(self.weatherAPIRepository.getWeatherInfoForCityWithUnitSuccessFailureCallsCount) == 0
                }
                it("THEN we notify updateItems") {
                    expect(self.output.updateItemsCallsCount) == 1
                }
                it("THEN we do not notify franceCitiesListNotFound error") {
                    expect(self.output.notifyFranceCitiesListNotFoundErrorCallsCount) == 0
                }
                it("THEN we do not notify franceCities empty list error") {
                    expect(self.output.notifyFranceCitiesEmptyListErrorCallsCount) == 0
                }
                it("THEN Item must be nil") {
                    expect(item).to(beNil())
                }
            }
        }
        describe("GIVEN I already retrieved valid list wih 10 items") {
            beforeEach {
                self.franceCitiesRepository.fetchSuccessFailureClosure = { success, _ in
                    let city0 = FranceCitiesRepositoryResponseProtocolMock()
                    city0.id = "0"
                    city0.name = "Paris"
                    let city1 = FranceCitiesRepositoryResponseProtocolMock()
                    city1.id = "1"
                    city1.name = "Marseille"
                    let city2 = FranceCitiesRepositoryResponseProtocolMock()
                    city2.id = "2"
                    city2.name = "Lyon"
                    let city3 = FranceCitiesRepositoryResponseProtocolMock()
                    city3.id = "3"
                    city3.name = "Dijon"
                    let city4 = FranceCitiesRepositoryResponseProtocolMock()
                    city4.id = "4"
                    city4.name = "Lille"
                    let city5 = FranceCitiesRepositoryResponseProtocolMock()
                    city5.id = "5"
                    city5.name = "Toulouse"
                    let city6 = FranceCitiesRepositoryResponseProtocolMock()
                    city6.id = "6"
                    city6.name = "Strasbourg"
                    let city7 = FranceCitiesRepositoryResponseProtocolMock()
                    city7.id = "7"
                    city7.name = "Rennes"
                    let city8 = FranceCitiesRepositoryResponseProtocolMock()
                    city8.id = "8"
                    city8.name = "Grenoble"
                    let city9 = FranceCitiesRepositoryResponseProtocolMock()
                    city9.id = "9"
                    city9.name = "Nice"
                    let mocks: [FranceCitiesRepositoryResponseProtocolMock] = [city0, city1, city2, city3, city4, city5, city6, city7, city8, city9]
                    success(mocks)
                }
                self.weatherAPIRepository.getWeatherInfoForCityWithUnitSuccessFailureClosure = { _, _, success, _ in
                    let response = WeatherAPICityInfoResponseProtocolMock()
                    response.id = 0
                    success(response)
                }
                self.interactor.retrieve()
            }
            context("WHEN I preload items") {
                beforeEach {
                    self.interactor.preloadItems(at: [5, 6, 7, 8, 9])
                }
                it("THEN we notify loading") {
                    expect(self.output.notifyLoadingCallsCount) == 1
                }
                it("THEN we set default values") {
                    expect(self.output.setDefaultValuesCallsCount) == 1
                }
                it("THEN we need to fetch franceCitites") {
                    expect(self.franceCitiesRepository.fetchSuccessFailureCallsCount) == 1
                }
                it("THEN we do not need to call weatherRepo") {
                    expect(self.weatherAPIRepository.getWeatherInfoForCityWithUnitSuccessFailureCallsCount) == 0
                }
                it("THEN we notify updateItems") {
                    expect(self.output.updateItemsCallsCount) == 1
                }
                it("THEN we do not notify franceCitiesListNotFound error") {
                    expect(self.output.notifyFranceCitiesListNotFoundErrorCallsCount) == 0
                }
                it("THEN we do not notify franceCities empty list error") {
                    expect(self.output.notifyFranceCitiesEmptyListErrorCallsCount) == 0
                }
            }
        }
    }
}
