//
//  CredentialsEntity.swift
//  
//
//  Created by Alexander Filimonov on 29/02/2020.
//

struct CredentialsEntity: Codable {

    // MARK: - Nested Types

    enum CodingKeys: String, CodingKey {
        case clientId = "client_id"
        case clientSecret = "client_secret"
        case authUrl = "authorize_url"
        case tokenUrl = "token_url"
        case callback = "callback"
    }

    // MARK: - Properties

    let clientId: String
    let clientSecret: String
    let authUrl: String
    let tokenUrl: String
    let callback: String

}
