//
//  PathConfig.swift
//  
//
//  Created by Alexander Filimonov on 01/03/2020.
//

import Foundation
import PathKit

public struct PathConfig {

    // MARK: - Public Properties

    public let outputFolderPath: Path
    public let templateFilePath: Path
    public let credentialsFilePath: Path

    // MARK: - Initialization

    public init(outputFolderPath: Path,
                templateFilePath: Path,
                credentialsFilePath: Path) {
        self.outputFolderPath = outputFolderPath
        self.templateFilePath = templateFilePath
        self.credentialsFilePath = credentialsFilePath
    }

}
