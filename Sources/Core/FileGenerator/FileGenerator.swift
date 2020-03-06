//
//  FileGenerator.swift
//  
//
//  Created by Alexander Filimonov on 06/03/2020.
//

import Foundation
import Models
import PathKit
import Stencil

public final class FileGenerator {

    // MARK: - Private Properties

    private let context: FileContext
    private let config: Config

    // MARK: - Initialization

    public init(context: FileContext,
                config: Config) {
        self.context = context
        self.config = config
    }

    // MARK: - Public Methods

    public func generate() throws {
        let templateFilePath = config.pathConfig.templateFilePath
        let templateFolder = Path(components: templateFilePath.components.dropLast())
        let templateName = templateFilePath.lastComponent
        let environment = Environment(loader: FileSystemLoader(paths: [templateFolder]))
        let renderedResult = try environment.renderTemplate(name: templateName,
                                                            context: context.context)

        let resultFolder = Path(components: context.filePath.components.dropLast())
        if !resultFolder.isDirectory {
            try resultFolder.mkpath()
        }
        
        try context.filePath.write(renderedResult)
    }

}
