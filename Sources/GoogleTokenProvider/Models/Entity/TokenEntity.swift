//
//  TokenEntity.swift
//  
//
//  Created by Alexander Filimonov on 29/02/2020.
//

import Foundation

struct TokenEntity: Codable {

    // MARK: - Properties

    let accessToken: String
    let refreshToken: String?
    let tokenType: String
    let expiresIn: Int
    let scope: String
    let creationTime: Date

    // MARK: - Initialization

    /// Base initialization from TokenEntry
    /// - Parameters:
    ///   - entry: TokenEntry from network
    ///   - refreshToken: Refresh token if it not provided in entry
    init(from entry: TokenEntry, refreshToken: String? = nil) {
        self.accessToken = entry.access_token
        self.refreshToken = entry.refresh_token ?? refreshToken
        self.tokenType = entry.token_type
        self.expiresIn = entry.expires_in
        self.scope = entry.scope
        self.creationTime = Date()
    }

}
