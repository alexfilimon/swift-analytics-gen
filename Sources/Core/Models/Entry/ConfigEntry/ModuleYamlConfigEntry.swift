//
//  ModuleYamlConfigEntry.swift
//  
//
//  Created by Alexander Filimonov on 12/03/2020.
//

import Foundation

public struct ModuleYamlConfigEntry: Codable {
    public let naming_postfix: String
    public let template_file_path: String
    public let output_folder_path: String
    public let spreadsheet_config: SpreadsheetYamlConfigEntry
}

extension ModuleYamlConfigEntry: EntityEncodable {

    func toEntity() throws -> ModuleConfig {
        return .init(namingPostfix: naming_postfix,
                     templateFilePath: .init(template_file_path),
                     outputFolderPath: .init(output_folder_path),
                     spreadsheetConfig: try spreadsheet_config.toEntity())
    }

}
