//
//  WeatherListInteractorOutput.swift
//  MyMeteo
//
//  Created by Sami Benmakhlouf on 30/11/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import Foundation

/// sourcery: AutoMockable
public protocol WeatherListInteractorOutput: class {

    func setDefaultValues()
    func notifyLoading()
    func updateItems()
    func notifyFranceCitiesListNotFoundError()
    func notifyFranceCitiesEmptyListError()
    func updateItem(atIndex index: Int, forCategoryIndex categoryIndex: Int)
}
