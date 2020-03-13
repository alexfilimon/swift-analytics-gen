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
//        try validate(moduleConfig: config.userPropertiesModuleConfig)
        try validate(credentialFilePath: config.baseConig.credentialsFilePath)
    }

}

// MARK: - Private Methods

private extension ConfigValidator {

    func validate(moduleConfig: ModuleConfig?) throws {
        guard let templateFilePath = moduleConfig?.templateFilePath else {
            return
        }
        guard templateFilePath.isFile else {
            throw BaseError.fileNotFound(path: templateFilePath)
        }
    }

    func validate(credentialFilePath: Path) throws {
        guard credentialFilePath.isFile else {
            throw BaseError.fileNotFound(path: credentialFilePath)
        }
    }

}
