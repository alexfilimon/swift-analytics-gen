//
//  ConfigParser.swift
//  
//
//  Created by Alexander Filimonov on 13/03/2020.
//

public protocol ConfigParser {
    func parse() throws -> Config
}
