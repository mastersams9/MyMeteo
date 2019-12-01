//
//  FileReader.swift
//  MyMeteo
//
//  Created by Sami Benmakhlouf on 01/12/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import Foundation

/// sourcery: AutoMockable
protocol FileReaderProtocol {
    func read(from name: String) -> Data?
}

class FileReader: FileReaderProtocol, JSONFileReadable {

    func read(from name: String) -> Data? {
        return readFile(named: name)
    }
}
