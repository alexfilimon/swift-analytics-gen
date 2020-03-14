//
//  Token.swift
//  
//
//  Created by Alexander Filimonov on 01/03/2020.
//

/// Struct that describes token and it's type 
public struct Token {

    // MARK: - Public Properties

    public let tokenType: String
    public let accessToken: String

    // MARK: - Initialization

    public init(tokenType: String,
                accessToken: String) {
        self.tokenType = tokenType
        self.accessToken = accessToken
    }

}
