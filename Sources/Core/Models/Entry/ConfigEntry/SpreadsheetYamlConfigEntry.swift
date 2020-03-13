//
//  SpreadsheetYamlConfigEntry.swift
//  
//
//  Created by Alexander Filimonov on 12/03/2020.
//

struct SpreadsheetYamlConfigEntry: Codable {
    let id: String
    let page_name: String
    let range: String
}

extension SpreadsheetYamlConfigEntry: EntityEncodable {

    func toEntity() throws -> SpreadsheetConfig {
        return .init(id: id, pageName: page_name, range: range)
    }

}
