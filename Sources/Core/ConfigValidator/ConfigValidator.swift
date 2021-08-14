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
        try validate(moduleConfig: config.userPropertiesModuleConfig)
        try validateFileExists(filePath: config.baseConfig.credentialsFilePath)
        try validate(categoriesTemplatePath: config.categoriesExtensionTemplatePath)
    }

}

// MARK: - Private Methods

private extension ConfigValidator {

    func validate(moduleConfig: ModuleConfig?) throws {
        guard let moduleConfig = moduleConfig else {
            return
        }
        try validate(spreadsheetConfig: moduleConfig.spreadsheetConfig)
        try validateFileExists(filePath: moduleConfig.templateFilePath)
    }

    func validate(spreadsheetConfig: SpreadsheetConfig) throws {
        if (spreadsheetConfig.id.nilIfEmpty() == nil) {
            throw BaseError.wrongValue(message: "id is empty")
        }
        if (spreadsheetConfig.pageName.nilIfEmpty() == nil) {
            throw BaseError.wrongValue(message: "pageName is empty")
        }
        if (spreadsheetConfig.range.nilIfEmpty() == nil) {
            throw BaseError.wrongValue(message: "range is empty")
        }
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
