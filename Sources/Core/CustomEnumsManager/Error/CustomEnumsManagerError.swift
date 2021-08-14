//
//  CustomEnumsManagerError.swift
//  
//
//  Created by Alexander Filimonov on 13/03/2020.
//

import Foundation

public enum CustomEnumsManagerError: LocalizedError {
    case enumDoesentExists(enumName: String)

    // MARK: - LocalizedError

    public var localizedDescription: String {
        switch self {
        case .enumDoesentExists(let enumName):
            return "Enum '\(enumName)' doesent exists in source"
        }
    }

    public var errorDescription: String? {
        return localizedDescription
    }

}
