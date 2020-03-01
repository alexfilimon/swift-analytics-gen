//
//  Config.swift
//  
//
//  Created by Alexander Filimonov on 01/03/2020.
//

import Foundation

public struct Config {

    // MARK: - Public Properties

    public let namingConfig: NamingConfig
    public let pathConfig: PathConfig
    public let language: Language
    public let spreadsheedCustomEnumsConfig: SpreadsheetConfig
    public let spreadsheetUserPropertiesConfig: SpreadsheetConfig
    public let spreadsheetEventsConfig: SpreadsheetConfig

    // MARK: - Initialization

    public init(namingConfig: NamingConfig,
                pathConfig: PathConfig,
                language: Language,
                spreadsheedCustomEnumsConfig: SpreadsheetConfig,
                spreadsheetUserPropertiesConfig: SpreadsheetConfig,
                spreadsheetEventsConfig: SpreadsheetConfig) {
        self.namingConfig = namingConfig
        self.pathConfig = pathConfig
        self.language = language
        self.spreadsheedCustomEnumsConfig = spreadsheedCustomEnumsConfig
        self.spreadsheetUserPropertiesConfig = spreadsheetUserPropertiesConfig
        self.spreadsheetEventsConfig = spreadsheetEventsConfig
    }
    
}
