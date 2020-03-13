//
//  Parameter.swift
//  
//
//  Created by Alexander Filimonov on 01/03/2020.
//

import Foundation

public struct Parameter {

    // MARK: - Public Properties

    public let name: String
    public let description: String?
    public let type: ParameterType

    // MARK: - Initialization

    public init(name: String,
                description: String?,
                type: ParameterType) {
        self.name = name
        self.description = description
        self.type = type
    }

}
