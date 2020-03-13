//
//  ModuleContextGenerator.swift
//  
//
//  Created by Alexander Filimonov on 13/03/2020.
//

public protocol ModuleContextGenerator {
    func generate() throws -> [FileContext]
}
