//
//  YamlConfigParser.swift
//  
//
//  Created by Alexander Filimonov on 12/03/2020.
//

import Yams
import PathKit

public final class YamlConfigParser: ConfigParser {

    // MARK: - Private Properties

    private let configFilePath: Path

    // MARK: - Initialization

    public init(configFilePath: Path) {
        self.configFilePath = configFilePath
    }

    // MARK: - Public Methods

    public func parse() throws -> Config {
        guard configFilePath.isFile else {
            throw BaseError.fileNotFound(path: configFilePath)
        }
        let configFileContent: String = try configFilePath.read()
        let decoder = YAMLDecoder()
        let configEntry = try decoder.decode(ConfigYamlEntry.self, from: configFileContent)
        return try configEntry.toEntity()
    }
    
}
