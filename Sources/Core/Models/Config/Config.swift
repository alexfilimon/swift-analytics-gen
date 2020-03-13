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

    public let baseConig: BaseConfig

    // MARK: - Initialization

    public init(customEnumModuleConfig: ModuleConfig?,
                eventsModuleConfig: ModuleConfig?,
                userPropertiesModuleConfig: ModuleConfig?,
                baseConig: BaseConfig) {
        self.eventsModuleConfig = eventsModuleConfig
        self.userPropertiesModuleConfig = userPropertiesModuleConfig
        self.customEnumModuleConfig = customEnumModuleConfig
        self.baseConig = baseConig
    }
    
}
