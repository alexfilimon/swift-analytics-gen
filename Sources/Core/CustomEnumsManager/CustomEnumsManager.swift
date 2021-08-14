//
//  CustomEnumsManager.swift
//  
//
//  Created by Alexander Filimonov on 13/03/2020.
//

import PathKit

/// Manager for getting customEnum's names and generating contexts for customEnums files
public final class CustomEnumsManager: ModuleContextGenerator, CustomEnumNameGettable {

    // MARK: - Private Properties

    private let moduleConfig: ModuleConfig
    private let baseConfig: BaseConfig
    private let customEnumsService: CustomEnumsAbstractService
    private var customEnums: [CustomEnum] = []

    // MARK: - Initialization

    public init(moduleConfig: ModuleConfig,
                baseConfig: BaseConfig,
                customEnumsService: CustomEnumsAbstractService) throws {
        self.moduleConfig = moduleConfig
        self.baseConfig = baseConfig
        self.customEnumsService = customEnumsService
    }

    // MARK: - Public Methods

    public func prepareForUse() throws {
        self.customEnums = try customEnumsService.getCustomEnums()
    }

    // MARK: - CustomEnumNameGettable

    public func getFinalName(forName customEnumName: String) throws -> String {
        guard let customEnum = customEnums.first(where: { $0.name == customEnumName }) else {
            throw CustomEnumsManagerError.enumDoesentExists(enumName: customEnumName)
        }
        return baseConfig.language.getCustomEnumName(
            name: "\(customEnum.name)_\(moduleConfig.namingPostfix)"
        )
    }

    // MARK: - ModuleContextGenerator

    public func generate() throws -> [FileContext] {
        return try customEnums.map {
            let fileName = baseConfig.language.getFileName(
                name: "\($0.name)_\(moduleConfig.namingPostfix)"
            )
            return FileContext(
                filePath: moduleConfig.outputFolderPath + Path(fileName),
                templateFilePath: moduleConfig.templateFilePath,
                context: try CustomEnumRawMapper(model: $0, moduleConfig: moduleConfig, baseConfig: baseConfig, parameterMapper: nil).toRaw()
            )
        }
    }

}
