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
    case wrongValue(message: String?)

    // MARK: - LocalizedError

    public var localizedDescription: String {
        switch self {
        case .fileNotFound(let path):
            return "File '\(path.lastComponent)' not found at path: \(path.absolute())"
        case .folderNotFound(let folderName):
            return "Folder: '\(folderName)' not found"
        case .unknownLanguage:
            return "Unknown language"
        case .unknownError:
            return "Unknown error"
        case .wrongValue(let message):
            return "Wrong value: \(message ?? "nil")"
        }
    }

    public var errorDescription: String? {
        return localizedDescription
    }

}
