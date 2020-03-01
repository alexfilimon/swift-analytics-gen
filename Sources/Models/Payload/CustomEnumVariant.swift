//
//  CustomEnumVariant.swift
//  
//
//  Created by Alexander Filimonov on 01/03/2020.
//

import Foundation

public struct CustomEnumVariant {

    // MARK: - Public Properties

    public let name: String
    public let description: String?
    public let parameters: [Parameter]

    // MARK: - Initialization

    public init(name: String,
            description: String?,
            parameters: [Parameter]) {
        self.name = name
        self.description = description
        self.parameters = parameters
    }

}
