//
//  ConfigYamlEntry.swift
//  
//
//  Created by Alexander Filimonov on 12/03/2020.
//

struct ConfigYamlEntry: Codable {
    let custom_enum_module_config: ModuleYamlConfigEntry?
    let events_module_config: ModuleYamlConfigEntry?
    let user_properties_module_config: ModuleYamlConfigEntry?
    let credentials_file_path: String
    let language: String
}

extension ConfigYamlEntry: EntityEncodable {

    func toEntity() throws -> Config {
        return .init(customEnumModuleConfig: try custom_enum_module_config?.toEntity(),
                     eventsModuleConfig: try events_module_config?.toEntity(),
                     userPropertiesModuleConfig: try user_properties_module_config?.toEntity(),
                     baseConig: .init(credentialsFilePath: .init(credentials_file_path),
                                      language: try LanguageParser(rawName: language).parse()))
    }

}
