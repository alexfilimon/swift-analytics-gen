//
//  FileContext.swift
//  
//
//  Created by Alexander Filimonov on 06/03/2020.
//

import PathKit

public struct FileContext {

    // MARK: - Public Properties

    public let filePath: Path
    public let templateFilePath: Path
    public let context: [String: Any]

    // MARK: - Initialization

    public init(filePath: Path,
                templateFilePath: Path,
                context: [String: Any]) {
        self.filePath = filePath
        self.templateFilePath = templateFilePath
        self.context = context
    }

}
