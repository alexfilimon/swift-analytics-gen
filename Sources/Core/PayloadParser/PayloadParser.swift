//
//  PayloadParser.swift
//  
//
//  Created by Alexander Filimonov on 01/03/2020.
//

import Foundation

public protocol PayloadParser {
    func parse() throws -> Payload
}
