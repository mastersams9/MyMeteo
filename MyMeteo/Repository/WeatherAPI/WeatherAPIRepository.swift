//
//  WeatherAPIRepository.swift
//  MyMeteo
//
//  Created by Sami Benmakhlouf on 30/11/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import Foundation

enum WeatherAPIRepositoryError: Error {
    case network
    case server
    case noData
    case unknown
}

class WeatherAPIRepository {
    private enum Constants {
        static let baseURL = "api.openweathermap.org/data/2.5/"
        static let placeholderCity = "$city"
        static let placeholderUnits = "$units"
        static let cityWeatherURL = "\(baseURL)/weather?q=\(placeholderCity)&units=\(placeholderUnits)"
        
    }
    
    private let api: WeatherAPI
    
    init(api: WeatherAPI) {
        self.api = api
    }
    
    private func prepareErrorManagement(from weatherAPIError: WeatherAPIError) -> WeatherAPIRepositoryError {
        switch weatherAPIError {
        case .network:
            return .network
        case .server:
            return .server
        case .noData:
            return .noData
        default:
            return .unknown
        }
    }
    
}

extension WeatherAPIRepository: WeatherAPIRepositoryInput {
    
    func getWeatherInfo(forCity city: String, withUnit unit: String, success: @escaping (WeatherAPICityInfoProtocol) -> Void, failure: ((WeatherAPIRepositoryError) -> Void)?) {
        api.request(urlString: Constants.cityWeatherURL,
                    method: .get,
                    accessToken: nil,
                    parameters: [:],
                    success: { data in
                                    DispatchQueue.global().async {
                                        do {
                                            DispatchQueue.main.async {
                                                success()
                                            }
                                        } catch {
                                            DispatchQueue.main.async {
                                                failure?(.unknown)
                                            }
                                        }
                                    }
                    },
                    failure: { [weak self] in
                                    guard let self = self else { return }
                                    let error = self.prepareErrorManagement(from: $0)
                                    DispatchQueue.main.async {
                                        failure?(error)
                                    }
                    })
    }

}
