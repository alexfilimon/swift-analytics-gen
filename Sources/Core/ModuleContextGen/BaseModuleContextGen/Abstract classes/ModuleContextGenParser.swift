//
//  ModuleContextGenParser.swift
//  
//
//  Created by Alexander Filimonov on 13/03/2020.
//

public class ModuleContextGenParser<Input, Output> {

    // MARK: - Public Properties

    public let input: Input

    // MARK: - Initialization

    required public init(input: Input) {
        self.input = input
    }

    // MARK: - Public Methods

    public func parse() throws -> [Output] {
        fatalError("Method \(#function) must be implemented")
    }

}
