//
//  FranceCitiesRepository.swift
//  MyMeteo
//
//  Created by Sami Benmakhlouf on 01/12/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import Foundation

class FranceCitiesRepository: JSONFileReadable {

    // MARK: - Constants

    private enum Constants {
        static let jsonFileName = "france_cities"
    }

    // MARK: - Properties

    private var fileReader: FileReaderProtocol

    // MARK: - Lifecycle

    init(fileReader: FileReaderProtocol) {
        self.fileReader = fileReader
    }
}

// MARK: - FranceCitiesRepositoryProtocol

extension FranceCitiesRepository: FranceCitiesRepositoryProtocol {
    func fetch(success: @escaping ([FranceCitiesRepositoryResponseProtocol]) -> Void,
               failure: @escaping (FranceCitiesRepositoryError) -> Void) {

        DispatchQueue.background.async {

            guard let dataResponse = self.fileReader.read(from: Constants.jsonFileName),
                let decodableResponse = try? JSONDecoder().decode([FranceCitiesRepositoryCodableResponse].self, from: dataResponse)else {
                DispatchQueue.main.async {
                    failure(.unknown)
                }
                return
            }
            let response = decodableResponse.compactMap {  FranceCitiesRepositoryResponse(id: $0.id, name: $0.name) }
            DispatchQueue.main.async {
                success(response)
                return
            }
        }
    }
}

// MARK: - Privates

private struct FranceCitiesRepositoryCodableResponse: Decodable {
    var id: String?
    var name: String?
}

// MARK: - FranceCitiesRepositoryResponseProtocol

private struct FranceCitiesRepositoryResponse: FranceCitiesRepositoryResponseProtocol {
    var id: String?
    var name: String?
}

