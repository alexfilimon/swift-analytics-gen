//
//  EventCategoryContextGenerator.swift
//  
//
//  Created by Alexander Filimonov on 14/03/2020.
//

import PathKit

/// Class for generating contexts for single eventCategory
public final class EventCategoryContextGenerator {

    // MARK: - Private Properties

    public let input: EventCategory
    public let baseConfig: BaseConfig
    public let moduleConfig: ModuleConfig
    public let parameterMapper: ParameterMapper

    // MARK: - Initialization

    public init(input: EventCategory,
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
        let fileName = baseConfig.language.getFileName(
            name: "\(input.name)_\(moduleConfig.namingPostfix)"
        )
        return FileContext(
            filePath: moduleConfig.outputFolderPath + Path(fileName),
            templateFilePath: moduleConfig.templateFilePath,
            context: try EventCategoryRawMapper(model: input, moduleConfig: moduleConfig, baseConfig: baseConfig, parameterMapper: parameterMapper).toRaw()
        )
    }
    
}
