//
//  ParameterRawMapperError.swift
//  
//
//  Created by Alexander Filimonov on 06/03/2020.
//

import Foundation

public enum ParameterRawMapperError: LocalizedError {
    case unknownType(String)

    // MARK: - LocalizedError

    public var localizedDescription: String {
        switch self {
        case .unknownType(let typeName):
            return "Type \(typeName) doesent exists in payload"
        }
    }

    public var errorDescription: String? {
        return localizedDescription
    }
}
