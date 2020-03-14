//
//  FileGenerator.swift
//  
//
//  Created by Alexander Filimonov on 06/03/2020.
//

import PathKit
import Stencil

/// Class for generating file from context
public final class FileGenerator {

    // MARK: - Private Properties

    private let context: FileContext

    // MARK: - Initialization

    /// Initializer for generator
    /// - Parameter context: context for generate
    public init(context: FileContext) {
        self.context = context
    }

    // MARK: - Public Methods

    /// Method for generating file
    public func generate() throws {
        // Check if template file exists
        let templateFilePath = context.templateFilePath
        guard templateFilePath.isFile else {
            throw BaseError.fileNotFound(path: templateFilePath)
        }
        let templateFolder = Path(components: templateFilePath.components.dropLast())
        let templateName = templateFilePath.lastComponent

        // render result
        let environment = Environment(loader: FileSystemLoader(paths: [templateFolder]))
        let renderedResult = try environment.renderTemplate(name: templateName,
                                                            context: context.context)

        // create output folder if needed
        let resultFolder = Path(components: context.filePath.components.dropLast())
        if !resultFolder.isDirectory {
            try resultFolder.mkpath()
        }

        // save rendered result into a file
        try context.filePath.write(renderedResult)
    }

}
