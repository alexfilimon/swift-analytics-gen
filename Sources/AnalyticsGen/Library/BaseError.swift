//
//  BaseError.swift
//  
//
//  Created by Alexander Filimonov on 14/02/2020.
//

import Foundation

enum BaseError: LocalizedError {
    case fileNotFound(fileName: String)
    case folderNotFound(folderName: String)
    case unknownLanguage
    case unknownError
}

extension BaseError {
    var errorDescription: String? {
        switch self {
        case .fileNotFound(let fileName):
            return "File: '\(fileName)' not found"
        case .folderNotFound(let folderName):
            return "Folder: '\(folderName)' not found"
        case .unknownLanguage:
            return "Unknown language"
        case .unknownError:
            return "Unknown error"
        }
    }
}
