//
//  PayloadParser.swift
//  
//
//  Created by Alexander Filimonov on 01/03/2020.
//

import Foundation
import Core

public protocol PayloadParser {
    func getPayload() throws -> Payload
}
