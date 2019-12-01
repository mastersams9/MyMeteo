//
//  JSONFileReadable.swift
//  MyMeteo
//
//  Created by Sami Benmakhlouf on 01/12/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import Foundation

public protocol JSONFileReadable: class {
    func readFile(named name: String) -> Data?
}

extension JSONFileReadable {

    public func readFile(named name: String) -> Data? {
        guard let path = Bundle(for: Self.self as AnyClass).path(forResource: name, ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                return nil
        }

        return data
    }
}
