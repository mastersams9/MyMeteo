//
//  FranceCitiesRepositoryProtocol.swift
//  MyMeteo
//
//  Created by Sami Benmakhlouf on 01/12/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import Foundation

enum FranceCitiesRepositoryError: Error {
    case unknown
}

/// sourcery: AutoMockable
protocol FranceCitiesRepositoryResponseProtocol {
    var id: String? { get }
    var name: String? { get }
}

/// sourcery: AutoMockable
protocol FranceCitiesRepositoryProtocol {
    func fetch(success: @escaping ([FranceCitiesRepositoryResponseProtocol]) -> Void,
               failure: @escaping (FranceCitiesRepositoryError) -> Void)
}
