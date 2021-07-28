//
//  FileContext.swift
//  
//
//  Created by Alexander Filimonov on 06/03/2020.
//

import PathKit
import Foundation

/// Entity that describes context of file to generate
public struct FileContext: Equatable {

    // MARK: - Public Properties

    public let filePath: Path
    public let templateFilePath: Path
    public let context: [String: Any]

    // MARK: - Initialization

    /// Initializer for struct
    /// - Parameters:
    ///   - filePath: path to generating file
    ///   - templateFilePath: path to file's template
    ///   - context: context for generating
    public init(filePath: Path,
                templateFilePath: Path,
                context: [String: Any]) {
        self.filePath = filePath
        self.templateFilePath = templateFilePath
        self.context = context
    }

    // MARK: - Equatable

    public static func == (lhs: FileContext, rhs: FileContext) -> Bool {
        return lhs.filePath == rhs.filePath
            && lhs.templateFilePath == rhs.templateFilePath
            && NSDictionary(dictionary: lhs.context).isEqual(to: rhs.context)
    }

}
