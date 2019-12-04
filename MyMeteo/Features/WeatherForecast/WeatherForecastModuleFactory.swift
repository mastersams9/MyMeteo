//
//  WeatherForecastModuleFactory.swift
//  MyMeteo
//
//
//
//  Created by Sami Benmakhlouf on 02/12/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import UIKit

class WeatherForecastModuleFactory {
    
    func makeView(withCityName cityName: String, withDelegate delegate: WeatherForecastViewDelegate? = nil) -> WeatherForecastView? {
        let api = WeatherAPI()
        let weatherAPIRepository = WeatherAPIRepository(api: api)
        let interactor = WeatherForecastInteractor(cityName: cityName, weatherAPIRepository: weatherAPIRepository)
        let presenter = WeatherForecastPresenter(interactor: interactor)
        interactor.output = presenter
        
        let view = UINib(nibName: "WeatherForecastView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? WeatherForecastView
        view?.presenter = presenter
        view?.imageLoader = MyMeteoImageLoader()
        view?.delegate = delegate
        presenter.output = view
        
        return view
    }
}
