//
//  UserPropertiesContextGenerator.swift
//  
//
//  Created by Alexander Filimonov on 11/09/2020.
//

import Foundation
import PathKit

/// Class for generating contexts for all user properties
public final class UserPropertiesContextGenerator {

    // MARK: - Private Properties

    public let userProperties: [UserProperty]
    public let baseConfig: BaseConfig
    public let moduleConfig: ModuleConfig
    public let parameterMapper: ParameterMapper

    // MARK: - Initialization

    public init(userProperties: [UserProperty],
                baseConfig: BaseConfig,
                moduleConfig: ModuleConfig,
                parameterMapper: ParameterMapper) {
        self.userProperties = userProperties
        self.baseConfig = baseConfig
        self.moduleConfig = moduleConfig
        self.parameterMapper = parameterMapper
    }

    // MARK: - Methods

    public func generate() throws -> FileContext {
        let fileName = baseConfig.language.getFileName(
            name: "user_properties"
        )
        return FileContext(
            filePath: moduleConfig.outputFolderPath + Path(fileName),
            templateFilePath: moduleConfig.templateFilePath,
            context: try UserPropertiesRawMapper(
                model: userProperties,
                moduleConfig: moduleConfig,
                baseConfig: baseConfig,
                parameterMapper: parameterMapper
            ).toRaw()
        )
    }
    
}
