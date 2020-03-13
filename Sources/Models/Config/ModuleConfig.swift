//
//  ModuleConfig.swift
//  
//
//  Created by Alexander Filimonov on 06/03/2020.
//

import Foundation
import PathKit

public struct ModuleConfig {

    // MARK: - Public Properties

    public let namingPostfix: String
    public let templateFilePath: Path
    public let outputFolderPath: Path
    public let spreadsheetConfig: SpreadsheetConfig

    // MARK: - Initialization

    public init(namingPostfix: String,
                templateFilePath: Path,
                outputFolderPath: Path,
                spreadsheetConfig: SpreadsheetConfig) {
        self.namingPostfix = namingPostfix
        self.templateFilePath = templateFilePath
        self.outputFolderPath = outputFolderPath
        self.spreadsheetConfig = spreadsheetConfig
    }

}
