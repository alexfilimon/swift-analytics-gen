//
//  TokenProvider.swift
//  
//
//  Created by Alexander Filimonov on 01/03/2020.
//

/// Protocol for abstract provider that returns token
public protocol TokenProvider {
    /// Method for getting access token for resource,
    /// Could throw error
    func getToken() throws -> Token
}
