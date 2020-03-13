//
//  CustomEnumsContextGenerator.swift
//  
//
//  Created by Alexander Filimonov on 06/03/2020.
//

import Foundation
import Models
import PathKit

public final class CustomEnumsContextGenerator {

    // MARK: - Private Properties

    private let config: Config
    private let payload: Payload

    // MARK: - Initialization

    public init(config: Config,
                payload: Payload) {
        self.config = config
        self.payload = payload
    }

    // MARK: - Public Methods

    public func generate() throws -> [FileContext] {
        return try payload.customEnums.map { try getFileGenerator(by: $0) }
    }

}

// MARK: - Private Methods

private extension CustomEnumsContextGenerator {

    func getFileGenerator(by customEnum: CustomEnum) throws -> FileContext {
        return .init(filePath: getFilePath(by: customEnum),
                     context: try CustomEnumRawMapper(model: customEnum, config: config, payload: payload).toRaw())
    }

    func getFilePath(by customEnum: CustomEnum) -> Path {
        let customEnumName = CustomEnumNameManager(customEnum: customEnum, customEnumsConfig: config.customEnumModuleConfig)
        let fileName = customEnumName.getName() + "." + config.language.fileExtension
        return config.customEnumModuleConfig.outputFolderPath + Path(fileName.capitalizingFirstLetter())
    }

}
