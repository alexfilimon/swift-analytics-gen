//
//  ConfigYamlEntry.swift
//  
//
//  Created by Alexander Filimonov on 12/03/2020.
//

import Foundation

public struct ConfigYamlEntry: Codable {
    public let events_module_config: ModuleYamlConfigEntry
    public let user_properties_module_config: ModuleYamlConfigEntry
    public let custom_enum_module_config: ModuleYamlConfigEntry
    public let credentials_file_path: String
    public let language: String
}

extension ConfigYamlEntry: EntityEncodable {

    public func toEntity() throws -> Config {
        return .init(eventsModuleConfig: try events_module_config.toEntity(),
                     userPropertiesModuleConfig: try user_properties_module_config.toEntity(),
                     customEnumModuleConfig: try custom_enum_module_config.toEntity(),
                     credentialsFilePath: .init(credentials_file_path),
                     language: try .init(raw: language))
    }

}
