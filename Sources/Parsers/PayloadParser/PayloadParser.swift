//
//  PayloadParser.swift
//  
//
//  Created by Alexander Filimonov on 01/03/2020.
//

import Foundation
import Core
import Models

public protocol PayloadParser {
    func getPayload() throws -> Payload
}
