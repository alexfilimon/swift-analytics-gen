//
//  TokenValidator.swift
//  
//
//  Created by Alexander Filimonov on 14/02/2020.
//

import Foundation

/// Class for validating accessToken
final class TokenValidator {

    // MARK: - Constants

    private enum Constants {
        static let precisionInSeconds = 100
    }

    // MARK: - Properties

    private let dateCreated: Date
    private let expiresSeconds: Int

    // MARK: - Initialization

    init(dateCreated: Date, expiresSeconds: Int) {
        self.dateCreated = dateCreated
        self.expiresSeconds = expiresSeconds
    }

    init(from token: TokenEntity) {
        self.dateCreated = token.creationTime
        self.expiresSeconds = token.expiresIn
    }

    // MARK: - Methods

    func isTokenValid() -> Bool {
        let calendar = Calendar.current
        guard
            let expirationDate = calendar.date(
                byAdding: .second,
                value: expiresSeconds - Constants.precisionInSeconds,
                to: dateCreated
            )
        else {
            return false
        }
        return expirationDate > Date()
    }

}
