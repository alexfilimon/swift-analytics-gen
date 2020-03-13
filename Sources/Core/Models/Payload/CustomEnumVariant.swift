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

    // MARK: - Initialization

    public init(name: String,
            description: String?) {
        self.name = name
        self.description = description
    }

}
