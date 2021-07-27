//
//  CustomEnumsAbstractService.swift
//  
//
//  Created by Alexander Filimonov on 14/03/2020.
//

/// Service for getting customEnums
public protocol CustomEnumsAbstractService {
    func getCustomEnums() throws -> [CustomEnum]
}
