//
//  UserPropertiesAbstractService.swift
//  
//
//  Created by Alexander Filimonov on 04/09/2020.
//

/// Service for getting user properties
public protocol UserPropertiesAbstractService {
    func getUserProperties() throws -> [UserProperty]
}
