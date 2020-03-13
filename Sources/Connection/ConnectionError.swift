//
//  SessionError.swift
//  
//
//  Created by Alexander Filimonov on 01/03/2020.
//

import Foundation

public enum ConnectionError: LocalizedError {
    case couldntCreateUrl
    case networkError
    case couldntParse

    // MARK: - LocalizedError

    public var localizedDescription: String {
        switch self {
        case .couldntCreateUrl:
            return "Couldnt create url"
        case .networkError:
            return "Some network error"
        case .couldntParse:
            return "Couldnt parse entity"
        }
    }

    public var errorDescription: String? {
        return localizedDescription
    }

}
