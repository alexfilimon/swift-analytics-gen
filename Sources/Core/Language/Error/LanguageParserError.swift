//
//  LanguageParserError.swift
//  
//
//  Created by Alexander Filimonov on 12/03/2020.
//

import Foundation

public enum LanguageParserError: LocalizedError {
    case unknownLanguage(String)

    // MARK: - LocalizedError

    public var localizedDescription: String {
        switch self {
        case .unknownLanguage(let rawName):
            return "Language '\(rawName)' is not supported yet. You are welcome to contribute for it's supporting!"
        }
    }

    public var errorDescription: String? {
        return localizedDescription
    }

}
