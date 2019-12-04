//
//  WeatherForecastInteractorTests.swift
//  MyMeteoTests
//
//  Created by Sami Benmakhlouf on 04/12/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import Nimble
import Quick
import XCTest

@testable import MyMeteo

class WeatherForecastInteractorTests: QuickSpec {
    
    // MARK: - Properties
    var output: WeatherForecastInteractorOutputMock!
    var weatherAPIRepository: WeatherAPIRepositoryInputMock!
    var interactor: WeatherForecastInteractor!
    
    // MARK: - Tests
    
    override func spec() {
        beforeEach {
            self.output = WeatherForecastInteractorOutputMock()
            self.weatherAPIRepository = WeatherAPIRepositoryInputMock()
            self.interactor = WeatherForecastInteractor(cityName: "Paris", weatherAPIRepository: self.weatherAPIRepository)
            self.interactor.output = self.output
        }
        describe("Given i want to see weather forecast and got server error") {
            beforeEach {
                self.weatherAPIRepository.getWeatherForecastInfoForCityWithUnitSuccessFailureClosure = { _, _, _, failure in
                    failure?(.server)
                }
            }
            context("WHEN I retrieve it") {
                beforeEach {
                    self.interactor.retrieve()
                }
                it("THEN notify loading should not be called") {
                    expect(self.output.notifySuccessCallsCount) == 0
                }
                it("THEN api should be called once") {
                    expect(self.weatherAPIRepository.getWeatherForecastInfoForCityWithUnitSuccessFailureCallsCount) == 1
                }
                it("THEN notify server error should be called once") {
                    expect(self.output.notifyServerErrorCallsCount) == 1
                }
                it("THEN notify network error should not be called") {
                    expect(self.output.notifyNetworkErrorCallsCount) == 0
                }
                it("THEN notify Unknown error should not be called") {
                    expect(self.output.notifyUnknownErrorCallsCount) == 0
                }
                it("THEN notify EmptyList error should not be called") {
                    expect(self.output.notifyEmptyListErrorCallsCount) == 0
                }
            }
        }
        
        describe("Given i want to see weather forecast and got network error") {
            beforeEach {
                self.weatherAPIRepository.getWeatherForecastInfoForCityWithUnitSuccessFailureClosure = { _, _, _, failure in
                    failure?(.network)
                }
            }
            context("WHEN I retrieve it") {
                beforeEach {
                    self.interactor.retrieve()
                }
                it("THEN notify loading should not be called") {
                    expect(self.output.notifySuccessCallsCount) == 0
                }
                it("THEN api should be called once") {
                    expect(self.weatherAPIRepository.getWeatherForecastInfoForCityWithUnitSuccessFailureCallsCount) == 1
                }
                it("THEN notify server error should not be called") {
                    expect(self.output.notifyServerErrorCallsCount) == 0
                }
                it("THEN notify network error should be called once") {
                    expect(self.output.notifyNetworkErrorCallsCount) == 1
                }
                it("THEN notify Unknown error should not be called") {
                    expect(self.output.notifyUnknownErrorCallsCount) == 0
                }
                it("THEN notify EmptyList error should not be called") {
                    expect(self.output.notifyEmptyListErrorCallsCount) == 0
                }
            }
        }
        
        
        
        describe("Given i want to see weather forecast and got unknwon error") {
            beforeEach {
                self.weatherAPIRepository.getWeatherForecastInfoForCityWithUnitSuccessFailureClosure = { _, _, _, failure in
                    failure?(.unknown)
                }
            }
            context("WHEN I retrieve it") {
                beforeEach {
                    self.interactor.retrieve()
                }
                it("THEN notify loading should not be called") {
                    expect(self.output.notifySuccessCallsCount) == 0
                }
                it("THEN api should be called once") {
                    expect(self.weatherAPIRepository.getWeatherForecastInfoForCityWithUnitSuccessFailureCallsCount) == 1
                }
                it("THEN notify server error should not be called") {
                    expect(self.output.notifyServerErrorCallsCount) == 0
                }
                it("THEN notify network error should not be called") {
                    expect(self.output.notifyNetworkErrorCallsCount) == 0
                }
                it("THEN notify Unknown error should not be called") {
                    expect(self.output.notifyUnknownErrorCallsCount) == 1
                }
                it("THEN notify EmptyList error should not be called") {
                    expect(self.output.notifyEmptyListErrorCallsCount) == 0
                }
            }
        }
        
        describe("Given i want to see weather forecast and got success but empty list") {
            beforeEach {
                self.weatherAPIRepository.getWeatherForecastInfoForCityWithUnitSuccessFailureClosure = { _, _, success, _ in
                    success([])
                }
            }
            context("WHEN I retrieve it") {
                beforeEach {
                    self.interactor.retrieve()
                }
                it("THEN notify loading should be called") {
                    expect(self.output.notifySuccessCallsCount) == 1
                }
                it("THEN api should be called once") {
                    expect(self.weatherAPIRepository.getWeatherForecastInfoForCityWithUnitSuccessFailureCallsCount) == 1
                }
                it("THEN notify server error should not be called once") {
                    expect(self.output.notifyServerErrorCallsCount) == 0
                }
                it("THEN notify network error should not be called") {
                    expect(self.output.notifyNetworkErrorCallsCount) == 0
                }
                it("THEN notify Unknown error should not be called") {
                    expect(self.output.notifyUnknownErrorCallsCount) == 0
                }
                it("THEN notify EmptyList error should not be called") {
                    expect(self.output.notifyEmptyListErrorCallsCount) == 0
                }
                
            }
        }
        
    }
    
}
