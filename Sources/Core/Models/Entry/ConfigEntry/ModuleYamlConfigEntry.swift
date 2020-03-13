//
//  ModuleYamlConfigEntry.swift
//  
//
//  Created by Alexander Filimonov on 12/03/2020.
//

struct ModuleYamlConfigEntry: Codable {
    let naming_postfix: String
    let template_file_path: String
    let output_folder_path: String
    let spreadsheet_config: SpreadsheetYamlConfigEntry
}

extension ModuleYamlConfigEntry: EntityEncodable {

    func toEntity() throws -> ModuleConfig {
        return .init(namingPostfix: naming_postfix,
                     templateFilePath: .init(template_file_path),
                     outputFolderPath: .init(output_folder_path),
                     spreadsheetConfig: try spreadsheet_config.toEntity())
    }

}
