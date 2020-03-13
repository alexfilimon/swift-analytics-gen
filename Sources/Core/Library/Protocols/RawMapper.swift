//
//  RawMapper.swift
//  
//
//  Created by Alexander Filimonov on 06/03/2020.
//

public class RawMapper<Model>: RawMappable {

    // MARK: - Private Properties

    public let model: Model
    public let moduleConfig: ModuleConfig
    public let baseConfig: BaseConfig
    public let parameterMapper: ParameterMapper?

    // MARK: - Initialization

    public init(model: Model,
                moduleConfig: ModuleConfig,
                baseConfig: BaseConfig,
                parameterMapper: ParameterMapper?) {
        self.model = model
        self.moduleConfig = moduleConfig
        self.baseConfig = baseConfig
        self.parameterMapper = parameterMapper
    }

    // MARK: - RawMappable

    public func toRaw() throws -> [String : Any] {
        fatalError("method \(#function) must be implemented")
    }

}
