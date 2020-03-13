//
//  ContextGenerator.swift
//  
//
//  Created by Alexander Filimonov on 13/03/2020.
//

public class ContextGenerator<Input> {

    // MARK: - Public Properties

    public let input: Input
    public let baseConfig: BaseConfig
    public let moduleConfig: ModuleConfig
    public let parameterMapper: ParameterMapper

    // MARK: - Initialization

    required public init(input: Input,
                         baseConfig: BaseConfig,
                         moduleConfig: ModuleConfig,
                         parameterMapper: ParameterMapper) {
        self.input = input
        self.baseConfig = baseConfig
        self.moduleConfig = moduleConfig
        self.parameterMapper = parameterMapper
    }

    // MARK: - Public Methods

    public func generate() throws -> FileContext {
        fatalError("Method \(#function) must be implemented")
    }

}
