//
//  CustomEnumNameGettable.swift
//  
//
//  Created by Alexander Filimonov on 13/03/2020.
//

/// Protocol for getting names for customEnums
public protocol CustomEnumNameGettable {
    func getFinalName(forName customEnumName: String) throws -> String
}
