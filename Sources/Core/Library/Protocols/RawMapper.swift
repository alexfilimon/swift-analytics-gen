//
//  RawMapper.swift
//  
//
//  Created by Alexander Filimonov on 06/03/2020.
//

/// Abstract class for translating some payload to raw representation
public class RawMapper<Model>: RawMappable {

    // MARK: - Private Properties

    public let model: Model
    public let moduleConfig: ModuleConfig
    public let baseConfig: BaseConfig
    public let parameterMapper: ParameterMapper?

    // MARK: - Initialization

    /// Initializer for RawMapper
    /// - Parameters:
    ///   - model: model, that need to be translated
    ///   - moduleConfig: module configuration
    ///   - baseConfig: base configuration
    ///   - parameterMapper: parameterMapper (should be passed for all mappers except CustomEnumMapper)
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

    /// Method for getting raw representation (must be overriden)
    public func toRaw() throws -> [String : Any] {
        fatalError("method \(#function) must be implemented")
    }

}
