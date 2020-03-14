//
//  ModuleContextGenerator.swift
//  
//
//  Created by Alexander Filimonov on 13/03/2020.
//

/// Protocol for generalizing modules that can generate contexts
public protocol ModuleContextGenerator {
    func generate() throws -> [FileContext]
}
