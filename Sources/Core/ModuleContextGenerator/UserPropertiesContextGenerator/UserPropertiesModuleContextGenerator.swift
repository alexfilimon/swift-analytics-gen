//
//  UserPropertiesModuleContextGenerator.swift
//  
//
//  Created by Alexander Filimonov on 04/09/2020.
//

/// Class for generating contexts for eventCategories
public final class UserPropertiesModuleContextGenerator: ModuleContextGenerator {

    // MARK: - Private Properties

    private let service: UserPropertiesAbstractService
    private let baseConfig: BaseConfig
    private let moduleConfig: ModuleConfig
    private let parameterMapper: ParameterMapper

    private var userProperties: [UserProperty]?

    // MARK: - Initialization

    /// Initializer for class
    /// - Parameters:
    ///   - service: service for getting user properties
    ///   - baseConfig: base config
    ///   - moduleConfig: module config
    ///   - parameterMapper: parameter mapper
    public init(service: UserPropertiesAbstractService,
                baseConfig: BaseConfig,
                moduleConfig: ModuleConfig,
                parameterMapper: ParameterMapper) {
        self.service = service
        self.baseConfig = baseConfig
        self.moduleConfig = moduleConfig
        self.parameterMapper = parameterMapper
    }

    // MARK: - Public Methods

    public func getUserProperties() throws -> [UserProperty] {
        try tryGetUserPropertiesFromService()
        return userProperties ?? []
    }

    // MARK: - ModuleContextGenerator

    /// Method for generating contexts
    public func generate() throws -> [FileContext] {
        try tryGetUserPropertiesFromService()
        return [
            try UserPropertiesContextGenerator(
                userProperties: userProperties ?? [],
                baseConfig: baseConfig,
                moduleConfig: moduleConfig,
                parameterMapper: parameterMapper
            ).generate()
        ]
    }

}

// MARK: - Private Methods

private extension UserPropertiesModuleContextGenerator {

    func tryGetUserPropertiesFromService() throws {
        guard userProperties == nil else {
            return
        }
        self.userProperties = try service.getUserProperties()
    }

}
