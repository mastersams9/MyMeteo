//
//  WeatherAPI.swift
//  MyMeteo
//
//  Created by Sami Benmakhlouf on 30/11/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import Foundation

enum WeatherAPIMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum WeatherAPIError: Error {
    case network
    case server
    case noData
    case unknown
}

protocol WeatherAPIProtocol {
    func cancel(urlString: String)
    func request(urlString: String,
                 method: WeatherAPIMethod,
                 parameters: [String: Any],
                 success: ((Data) -> Void)?,
                 failure: ((WeatherAPIError) -> Void)?)
}

class WeatherAPI {

    private let session: URLSession
    private var list: [String] = []

    init() {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 108000.0
        sessionConfig.timeoutIntervalForResource = 108000.0
        sessionConfig.requestCachePolicy = .reloadIgnoringLocalCacheData
        sessionConfig.urlCache = nil
        self.session = URLSession(configuration: sessionConfig)
    }

    // MARK: - Private
    
    private func removeToList(urlString: String) {
        list.removeAll(where: {
            $0 == urlString
        })
    }
    
    private func addToList(urlString: String) {
        list.append(urlString)
    }
    
    private func checkIfCalled(urlString: String) -> Bool {
        if list.contains(urlString) {
            return true
        }
        return false
    }

    private func launchRequestURL(_ url: URL,
                                 method: WeatherAPIMethod,
                                 accessToken: String?,
                                 parameters: [String: Any],
                                 completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let accessToken = accessToken {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        request.httpMethod = method.rawValue

        if !parameters.isEmpty {
            let parametersData = try? JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = parametersData
        }

        let task: URLSessionDataTask = session.dataTask(with: request,
                                                        completionHandler: completionHandler)

        task.resume()
    }

}

// MARK: - MoblihAPIProtocol

extension WeatherAPI: WeatherAPIProtocol {

    func cancel(urlString: String) {
        session.getAllTasks { tasks in
            tasks
                .filter { $0.state == .running }
                .filter {
                    return $0.originalRequest?.url?.absoluteString == urlString
                }.first?
                .cancel()
        }
    }
    
    func request(urlString: String,
                 method: WeatherAPIMethod,
                 parameters: [String: Any],
                 success: ((Data) -> Void)?,
                 failure: ((WeatherAPIError) -> Void)?) {
        
        if self.checkIfCalled(urlString: urlString) {
            return
        }
        
        self.addToList(urlString: urlString)
        
        guard let url = URL(string: urlString) else {
            failure?(.unknown)
            return
        }

        launchRequestURL(url, method: method, accessToken: nil, parameters: parameters) { dataOpt, response, error in
            
            if error != nil {
                self.removeToList(urlString: urlString)
            }
            
            switch (response as? HTTPURLResponse)?.statusCode ?? -1 {
            case 200...210:
                guard let data = dataOpt else {
                    DispatchQueue.main.async {
                        failure?(.noData)
                    }
                    return
                }
                DispatchQueue.main.async {
                    success?(data)
                }
            case 400...403:
                DispatchQueue.main.async {
                    failure?(.server)
                }
            case 404:
                DispatchQueue.main.async {
                    failure?(.noData)
                }
            case 500:
                DispatchQueue.main.async {
                    failure?(.server)
                }
            default:
                switch (error as NSError?)?.code {
                case -1009:
                    DispatchQueue.main.async {
                        failure?(.network)
                    }
                case 500:
                    DispatchQueue.main.async {
                        failure?(.server)
                    }
                default:
                    DispatchQueue.main.async {
                        failure?(.unknown)
                    }
                }
            }
        }
        
    }
}
