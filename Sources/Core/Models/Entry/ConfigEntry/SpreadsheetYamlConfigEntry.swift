//
//  SpreadsheetYamlConfigEntry.swift
//  
//
//  Created by Alexander Filimonov on 12/03/2020.
//

import Foundation

public struct SpreadsheetYamlConfigEntry: Codable {
    public let id: String
    public let page_name: String
    public let range: String
}

extension SpreadsheetYamlConfigEntry: EntityEncodable {

    func toEntity() throws -> SpreadsheetConfig {
        return .init(id: id, pageName: page_name, range: range)
    }

}
