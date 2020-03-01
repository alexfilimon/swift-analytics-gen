//
//  FileService.swift
//  
//
//  Created by Alexander Filimonov on 29/02/2020.
//

import Foundation
import PathKit

/// Class for reading and writing codable entity to FileSystem
public final class FileService<Content: Codable> {

    // MARK: - Private Properties

    private let filePath: Path

    // MARK: - Initialization

    /// Base initialization
    /// - Parameter filePath: path to file (if it doesen't exist -> it creates automatically)
    public init(filePath: Path) {
        self.filePath = filePath
    }

    // MARK: - Methods

    /// Method for saving file in FileSystem (can throw error)
    /// - Parameter content: codable content that needs to be saved
    public func save(content: Content) throws {
        let data = try JSONEncoder().encode(content)
        try createFoldersIfNeeded(for: filePath)
        try filePath.write(data)
    }

    /// Method for loading codable content from file (can throw error)
    public func load() throws -> Content {
        guard filePath.isFile else {
            throw FileServiceError.fileDoesentExist(filePath: filePath.absolute().string)
        }
        let data = try filePath.read()
        let content = try JSONDecoder().decode(Content.self, from: data)
        return content
    }

}

// MARK: - Private Methods

private extension FileService {

    /// Method for creating all folders in path
    /// - Parameter filePath: path to file
    func createFoldersIfNeeded(for filePath: Path) throws {
        var folderToWriteComponents = filePath.components
        folderToWriteComponents.removeLast()
        let folderToWrite = Path(components: folderToWriteComponents)
        if !folderToWrite.exists {
            try folderToWrite.mkpath()
        }
    }

}
