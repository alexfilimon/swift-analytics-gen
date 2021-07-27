//
//  Config.swift
//  
//
//  Created by Alexander Filimonov on 01/03/2020.
//

import PathKit

public struct Config {

    // MARK: - Public Properties

    public let customEnumModuleConfig: ModuleConfig?

    public let eventsModuleConfig: ModuleConfig?
    public let userPropertiesModuleConfig: ModuleConfig?

    public let baseConfig: BaseConfig

    public let categoriesExtensionTemplatePath: Path?
    public let categoriesExtensionOutputPath: Path?

    // MARK: - Initialization

    public init(customEnumModuleConfig: ModuleConfig?,
                eventsModuleConfig: ModuleConfig?,
                userPropertiesModuleConfig: ModuleConfig?,
                baseConfig: BaseConfig,
                categoriesExtensionTemplatePath: String?,
                categoriesExtensionOutputPath: String?) {
        self.eventsModuleConfig = eventsModuleConfig
        self.userPropertiesModuleConfig = userPropertiesModuleConfig
        self.customEnumModuleConfig = customEnumModuleConfig
        self.baseConfig = baseConfig
        // TODO: remove force unwrap
        self.categoriesExtensionTemplatePath = categoriesExtensionTemplatePath == nil
            ? nil
            : Path(categoriesExtensionTemplatePath!)
        self.categoriesExtensionOutputPath = categoriesExtensionOutputPath == nil
            ? nil
            : Path(categoriesExtensionOutputPath!)
    }
    
}
