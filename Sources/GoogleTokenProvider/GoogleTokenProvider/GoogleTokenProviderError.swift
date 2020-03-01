//
//  GoogleTokenProviderError.swift
//  
//
//  Created by Alexander Filimonov on 29/02/2020.
//

import Foundation

public enum GoogleTokenProviderError: LocalizedError {
    case couldntFindCredentials
    case couldntCreateUrl
    case errorWhileGettingAuthCode(String)
    case unknownErrorWhileGettingAuthCode
    case noRefreshToken

    // MARK: - LocalizedError

    public var localizedDescription: String {
        switch self {
        case .couldntFindCredentials:
            return "Couldnt find file with credentials"
        case .couldntCreateUrl:
            return "Couldnt create url"
        case .errorWhileGettingAuthCode(let message):
            return "Error in getting auth code: \(message)"
        case .unknownErrorWhileGettingAuthCode:
            return "Unknown error in getting auth code"
        case .noRefreshToken:
            return "There is no refresh token in token file. Try to remove file '~/.googleTokenProvider/token_info.json'"
        }
    }

    public var errorDescription: String? {
        return localizedDescription
    }

}
