//
//  ConfigYamlEntry.swift
//  
//
//  Created by Alexander Filimonov on 12/03/2020.
//

import PathKit

struct ConfigYamlEntry: Codable {
    let custom_enum_module_config: ModuleYamlConfigEntry?
    let events_module_config: ModuleYamlConfigEntry?
    let user_properties_module_config: ModuleYamlConfigEntry?
    let credentials_file_path: String
    let language: String
    let categories_extension_template_path: String?
    let categories_extension_output_path: String?
}

extension ConfigYamlEntry: EntityEncodable {

    func toEntity() throws -> Config {
        return .init(customEnumModuleConfig: try custom_enum_module_config?.toEntity(),
                     eventsModuleConfig: try events_module_config?.toEntity(),
                     userPropertiesModuleConfig: try user_properties_module_config?.toEntity(),
                     baseConfig: .init(credentialsFilePath: .init(credentials_file_path),
                                       language: try LanguageParser(rawName: language).parse()),
                     categoriesExtensionTemplatePath: categories_extension_template_path,
                     categoriesExtensionOutputPath: categories_extension_output_path)
    }

}
