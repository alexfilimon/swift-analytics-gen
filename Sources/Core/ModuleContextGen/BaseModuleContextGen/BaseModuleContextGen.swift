//
//  BaseModuleContextGenerator.swift
//  
//
//  Created by Alexander Filimonov on 13/03/2020.
//

public final class BaseModuleContextGen<
    ServiceOutput,
    ParserOutput,
    Service: ModuleContextGeneratorService<ServiceOutput>,
    Parser: ModuleContextGenParser<ServiceOutput, ParserOutput>,
    ContextGen: ContextGenerator<ParserOutput>
>: ModuleContextGenerator {

    // MARK: - Private Properties

    private let service: ModuleContextGeneratorService<ServiceOutput>
    private let baseConfig: BaseConfig
    private let moduleConfig: ModuleConfig
    private let parameterMapper: ParameterMapper

    // MARK: - Initialization

    public init(service: ModuleContextGeneratorService<ServiceOutput>,
                baseConfig: BaseConfig,
                moduleConfig: ModuleConfig,
                parameterMapper: ParameterMapper) {
        self.service = service
        self.baseConfig = baseConfig
        self.moduleConfig = moduleConfig
        self.parameterMapper = parameterMapper
    }


    // MARK: - ModuleContextGenerator

    public func generate() throws -> [FileContext] {
        let serviceResponse = try service.getPayload()
        let parserResult = try Parser(input: serviceResponse).parse()
        let contexts = try parserResult.map {
            try ContextGen(input: $0, baseConfig: baseConfig, moduleConfig: moduleConfig, parameterMapper: parameterMapper).generate()
        }
        return contexts
    }

}
