//
//  ConfigValidator.swift
//  
//
//  Created by Alexander Filimonov on 13/03/2020.
//

import PathKit

public final class ConfigValidator {

    // MARK: - Private Properties

    private let config: Config

    // MARK: - Initialization

    public init(config: Config) {
        self.config = config
    }

    // MARK: - Public Methods

    public func validate() throws {
        try validate(moduleConfig: config.eventsModuleConfig)
        try validate(moduleConfig: config.customEnumModuleConfig)
        try validateFileExists(filePath: config.baseConfig.credentialsFilePath)
        try validate(categoriesTemplatePath: config.categoriesExtensionTemplatePath)
    }

}

// MARK: - Private Methods

private extension ConfigValidator {

    func validate(moduleConfig: ModuleConfig?) throws {
        guard let templateFilePath = moduleConfig?.templateFilePath else {
            return
        }
        try validateFileExists(filePath: templateFilePath)
    }

    func validate(categoriesTemplatePath: Path?) throws {
        guard let categoriesTemplatePathUnwrapped = categoriesTemplatePath else {
            return
        }
        try validateFileExists(filePath: categoriesTemplatePathUnwrapped)
    }

    func validateFileExists(filePath: Path) throws {
        guard filePath.isFile else {
            throw BaseError.fileNotFound(path: filePath)
        }
    }

}
