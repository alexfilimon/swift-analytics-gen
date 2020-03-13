//
//  CustomEnumNameGettable.swift
//  
//
//  Created by Alexander Filimonov on 13/03/2020.
//

public protocol CustomEnumNameGettable {
    func getFinalName(forName customEnumName: String) throws -> String
}
