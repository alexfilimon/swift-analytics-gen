//
//  ParameterMapperError.swift
//  
//
//  Created by Alexander Filimonov on 10/02/2021.
//

import Foundation

public enum ParameterMapperError: LocalizedError {
    case thereIsNoEnumGettable(forEnum: String)

    // MARK: - LocalizedError

    public var localizedDescription: String {
        switch self {
        case .thereIsNoEnumGettable(let enumName):
            return "Entity `CustomEnumGettable` must be provided for enum `\(enumName)`"
        }
    }

    public var errorDescription: String? {
        return localizedDescription
    }

}
