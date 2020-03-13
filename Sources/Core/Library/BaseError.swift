//
//  BaseError.swift
//  
//
//  Created by Alexander Filimonov on 14/02/2020.
//

import Foundation
import PathKit

public enum BaseError: LocalizedError {
    case fileNotFound(path: Path)
    case folderNotFound(folderName: String)
    case unknownLanguage
    case unknownError
}

extension BaseError {
    public var errorDescription: String? {
        switch self {
        case .fileNotFound(let path):
            return "File '\(path.lastComponent)' not found at path: \(path.absolute())"
        case .folderNotFound(let folderName):
            return "Folder: '\(folderName)' not found"
        case .unknownLanguage:
            return "Unknown language"
        case .unknownError:
            return "Unknown error"
        }
    }
}
