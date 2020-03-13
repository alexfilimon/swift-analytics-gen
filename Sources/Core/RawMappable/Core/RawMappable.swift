//
//  RawMappable.swift
//  
//
//  Created by Alexander Filimonov on 06/03/2020.
//

import Foundation

public protocol RawMappable {
    func toRaw() throws -> [String: Any]
}
