//
//  NamingConfig.swift
//  
//
//  Created by Alexander Filimonov on 01/03/2020.
//

import Foundation

public struct NamingConfig {

    // MARK: - Public Properties

    public let categoryNamePostfix: String
    public let userPropertyPostfix: String

    // MARK: - Initialization

    public init(categoryNamePostfix: String,
                userPropertyPostfix: String) {
        self.categoryNamePostfix = categoryNamePostfix
        self.userPropertyPostfix = userPropertyPostfix
    }

}
