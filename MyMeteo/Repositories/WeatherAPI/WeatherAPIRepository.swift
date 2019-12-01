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
        static let baseURL = "https://api.openweathermap.org/data/2.5"
        static let placeholderCity = "$city"
        static let placeholderUnits = "$units"
        static let placeholderIconCode = "$iconCode"
        static let placeholderLanguage = "$language"
        static let defaultLanguage = "fr"
        static let apiKey = "9f4e4f0ca43e636551b83b52d7284ca7"
        static let cityWeatherURL = "\(baseURL)/weather?q=\(placeholderCity)&appid=\(apiKey)&units=\(placeholderUnits)&lang=\(placeholderLanguage)"
        static let iconURL = "http://openweathermap.org/img/wn/\(placeholderIconCode)@2x.png"
        
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

// MARK: - WeatherAPIRepositoryInput

extension WeatherAPIRepository: WeatherAPIRepositoryInput {

    func cancel(forCity city: String, withUnit unit: WeatherAPIRepositoryUnit) {
        let urlString = Constants.cityWeatherURL.replacingOccurrences(of: Constants.placeholderCity, with: city).replacingOccurrences(of: Constants.placeholderUnits, with: unit.description).replacingOccurrences(of: Constants.placeholderLanguage, with: Locale.current.languageCode ?? Constants.defaultLanguage)
        api.cancel(urlString: urlString)
    }

    func getWeatherInfo(forCity city: String,
                        withUnit unit: WeatherAPIRepositoryUnit,
                        success: @escaping (WeatherAPICityInfoResponseProtocol) -> Void,
                        failure: ((WeatherAPIRepositoryError, String) -> Void)?) {
        let urlString = Constants.cityWeatherURL.replacingOccurrences(of: Constants.placeholderCity, with: city).replacingOccurrences(of: Constants.placeholderUnits, with: unit.description).replacingOccurrences(of: Constants.placeholderLanguage, with: Locale.current.languageCode ?? Constants.defaultLanguage)
        api.request(urlString: urlString,
                    method: .get,
                    parameters: [:],
                    success: { data in
                        DispatchQueue.background.async {
                            do {
                                let decodableResponse = try JSONDecoder().decode(WeatherAPICityInfoCodableResponse.self, from: data)
                                let windResponse = WeatherAPIWindResponse(speed: decodableResponse.wind?.speed,
                                                                          deg: decodableResponse.wind?.deg)
                                let mainResponse = WeatherAPIMainResponse(temp: decodableResponse.main?.temp,
                                                                          pressure: decodableResponse.main?.pressure,
                                                                          humidity: decodableResponse.main?.humidity,
                                                                          tempMin: decodableResponse.main?.temp_min,
                                                                          tempMax: decodableResponse.main?.temp_max)


                                var iconURL: URL? = nil
                                if let decodableResponseWeatherIcon = decodableResponse.weather?.first?.icon {
                                    iconURL = URL(string: Constants.iconURL.replacingOccurrences(of: Constants.placeholderIconCode, with: decodableResponseWeatherIcon))
                                }

                                let weatherResponse = WeatherAPIWeatherResponse(id: decodableResponse.weather?.first?.id,
                                                                                main: decodableResponse.weather?.first?.main,
                                                                                description: decodableResponse.weather?.first?.description,
                                                                                iconUrl: iconURL)

                                let response = WeatherAPICityInfoResponse(id: decodableResponse.id,
                                                                          name: decodableResponse.name,
                                                                          weather: weatherResponse,
                                                                          main: mainResponse,
                                                                          wind: windResponse)

                                DispatchQueue.main.async {
                                    success(response)
                                    return
                                }

                            }
                            catch {
                                print("error: \(error)")
                                    DispatchQueue.main.async {
                                        failure?(.unknown, city)
                                    }
                                    return
                            }


                        }
        },
                    failure: { [weak self] in
                        guard let self = self else { return }
                        let error = self.prepareErrorManagement(from: $0)
                        DispatchQueue.main.async {
                            failure?(error, city)
                        }
        })
    }

}

// MARK: - Privates

// MARK: - Codables

private struct WeatherAPIWeatherCodableResponse: Decodable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}

private struct WeatherAPIMainCodableResponse: Decodable {
    var temp: Double?
    var pressure: Double?
    var humidity: Int?
    var temp_min: Double?
    var temp_max: Double?
}

private struct WeatherAPIWindCodableResponse: Decodable {
    var speed: Double?
    var deg: Double?
}

private struct WeatherAPICityInfoCodableResponse: Decodable {
    var id: Int?
    var name: String?
    var weather: [WeatherAPIWeatherCodableResponse]?
    var main: WeatherAPIMainCodableResponse?
    var wind: WeatherAPIWindCodableResponse?
}

// MARK: - WeatherAPIWeatherResponseProtocol

private struct WeatherAPIWeatherResponse: WeatherAPIWeatherResponseProtocol {
    var id: Int?
    var main: String?
    var description: String?
    var iconUrl: URL?
}

// MARK: - WeatherAPIMainResponseProtocol

private struct WeatherAPIMainResponse: WeatherAPIMainResponseProtocol {
    var temp: Double?
    var pressure: Double?
    var humidity: Int?
    var tempMin: Double?
    var tempMax: Double?
}

// MARK: - WeatherAPIWindResponseProtocol

private struct WeatherAPIWindResponse: WeatherAPIWindResponseProtocol {
    var speed: Double?
    var deg: Double?
}

// MARK: - WeatherAPICityInfoResponseProtocol

private struct WeatherAPICityInfoResponse: WeatherAPICityInfoResponseProtocol {
    var id: Int?
    var name: String?
    var weather: WeatherAPIWeatherResponseProtocol?
    var main: WeatherAPIMainResponseProtocol?
    var wind: WeatherAPIWindResponseProtocol?
}
