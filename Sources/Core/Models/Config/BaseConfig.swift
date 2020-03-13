//
//  BaseConfig.swift
//  
//
//  Created by Alexander Filimonov on 13/03/2020.
//

import PathKit

public struct BaseConfig {

    // MARK: - Public Properties

    public let credentialsFilePath: Path
    public let language: Language

    // MARK: - Initialization

    public init(credentialsFilePath: Path,
                language: Language) {
        self.credentialsFilePath = credentialsFilePath
        self.language = language
    }

}
