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
        
    }
    
}

