//
//  DispatchQueue+Background.swift
//  MyMeteo
//
//  Created by Sami Benmakhlouf on 01/12/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import Foundation

extension DispatchQueue {

    public static var background: DispatchQueue {
        return .global(qos: .background)
    }
}
