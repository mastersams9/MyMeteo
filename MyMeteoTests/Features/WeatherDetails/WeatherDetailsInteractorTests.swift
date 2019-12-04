//
//  WeatherDetailsInteractorTests.swift
//  MyMeteoTests
//
//  Created by Sami Benmakhlouf on 04/12/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import Nimble
import Quick
import XCTest

@testable import MyMeteo

class WeatherDetailsInteractorTests: QuickSpec {
    
    // MARK: - Properties
    var output: WeatherDetailsInteractorOutputMock!
    var weatherAPIRepository: WeatherAPIRepositoryInputMock!
    var interactor: WeatherDetailsInteractor!
    
    // MARK: - Tests
    
    override func spec() {
        beforeEach {
            self.output = WeatherDetailsInteractorOutputMock()
            self.weatherAPIRepository = WeatherAPIRepositoryInputMock()
            self.interactor = WeatherDetailsInteractor(cityName: "Paris", weatherAPIRepository: self.weatherAPIRepository)
            self.interactor.output = self.output
        }
        describe("Given i want to see weather details and got error") {
            beforeEach {
                self.weatherAPIRepository.getWeatherInfoForCityWithUnitSuccessFailureClosure = { _, _, _, failure in
                    failure?(.server, "Paris")
                }
            }
            context("WHEN I retrieve it") {
                beforeEach {
                    self.interactor.retrieve()
                }
                it("THEN notify loading should not be called") {
                    expect(self.output.notifySuccessItemCallsCount) == 0
                }
                it("THEN api should be called once") {
                    expect(self.weatherAPIRepository.getWeatherInfoForCityWithUnitSuccessFailureCallsCount) == 1
                }
                it("THEN notify server error should be called once") {
                    expect(self.output.notifyServerErrorCallsCount) == 1
                }
            }
        }
        
        
        describe("Given i want to see weather details and got success") {
             beforeEach {
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
                 it("THEN notify loading should be called") {
                     expect(self.output.notifySuccessItemCallsCount) == 1
                 }
                 it("THEN api should be called once") {
                     expect(self.weatherAPIRepository.getWeatherInfoForCityWithUnitSuccessFailureCallsCount) == 1
                 }
                 it("THEN notify server error should be called once") {
                     expect(self.output.notifyServerErrorCallsCount) == 0
                 }
             }
         }
        
        describe("Given i want to updateCategories") {
            context("WHEN I prepare") {
                beforeEach {
                     self.interactor.prepare()
                 }
                 it("THEN notify loading should not be called") {
                     expect(self.output.notifySuccessItemCallsCount) == 0
                 }
                 it("THEN api should not be called once") {
                     expect(self.weatherAPIRepository.getWeatherInfoForCityWithUnitSuccessFailureCallsCount) == 0
                 }
                 it("THEN notify server error should be called") {
                     expect(self.output.notifyServerErrorCallsCount) == 0
                 }
                it("THEN updateCategories should be called once") {
                    expect(self.output.updateCategoriesCityNameCallsCount) == 1
                }
             }
         }
        
    }
    
}


