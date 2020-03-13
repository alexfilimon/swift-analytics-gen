//
//  Config.swift
//  
//
//  Created by Alexander Filimonov on 01/03/2020.
//

import Foundation
import PathKit

public struct Config {

    // MARK: - Public Properties

    public let eventsModuleConfig: ModuleConfig
    public let userPropertiesModuleConfig: ModuleConfig
    public let customEnumModuleConfig: ModuleConfig

    public let credentialsFilePath: Path
    public let language: Language

    // MARK: - Initialization

    public init(eventsModuleConfig: ModuleConfig,
                userPropertiesModuleConfig: ModuleConfig,
                customEnumModuleConfig: ModuleConfig,
                credentialsFilePath: Path,
                language: Language) {
        self.eventsModuleConfig = eventsModuleConfig
        self.userPropertiesModuleConfig = userPropertiesModuleConfig
        self.customEnumModuleConfig = customEnumModuleConfig
        self.credentialsFilePath = credentialsFilePath
        self.language = language
    }
    
}
