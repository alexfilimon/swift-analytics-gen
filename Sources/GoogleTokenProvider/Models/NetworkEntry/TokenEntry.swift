//
//  TokenEntry.swift
//  
//
//  Created by Alexander Filimonov on 01/03/2020.
//

import Foundation

struct TokenEntry: Decodable {
    let access_token: String
    let refresh_token: String?
    let token_type: String
    let expires_in: Int
    let scope: String
}
