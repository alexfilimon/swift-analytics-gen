//
//  CustomEnumsManager.swift
//  
//
//  Created by Alexander Filimonov on 13/03/2020.
//

import Service
import PathKit

public final class CustomEnumsManager: ModuleContextGenerator, CustomEnumNameGettable {

    // MARK: - Private Properties

    private let moduleConfig: ModuleConfig?
    private let baseConfig: BaseConfig
    private let spreadsheetService: GoogleSpreadsheetAbstractService
    private var customEnums: [CustomEnum] = []

    // MARK: - Initialization

    public init(moduleConfig: ModuleConfig?,
                baseConfig: BaseConfig) throws {
        self.moduleConfig = moduleConfig
        self.baseConfig = baseConfig
        self.spreadsheetService = try GoogleSpreadsheetService(creadentialFilePath: baseConfig.credentialsFilePath)
    }

    // MARK: - Public Methods

    public func prepareForUse() throws {
        guard let spreadsheetConfig = moduleConfig?.spreadsheetConfig else {
            return
        }
        let requestEntiry = SpreadsheetRequestEntity(id: spreadsheetConfig.id,
                                                     pageName: spreadsheetConfig.pageName,
                                                     range: spreadsheetConfig.range)
        let spreadsheetEntry = try spreadsheetService.getGoogleSheetData(by: requestEntiry)
        customEnums = SpreadsheetCustomEnumParser(spreadsheet: .init(from: spreadsheetEntry)).getCustomEnums()
    }

    // MARK: - CustomEnumNameGettable

    public func getFinalName(forName customEnumName: String) throws -> String {
        guard
            let moduleConfig = moduleConfig,
            let customEnum = customEnums.first(where: { $0.name == customEnumName })
        else {
            throw CustomEnumsManagerError.unknownEnum
        }
        return "\(customEnum.name)_\(moduleConfig.namingPostfix)".snackToCamel(capitalizingFirst: true)
    }

    // MARK: - ModuleContextGenerator

    public func generate() throws -> [FileContext] {
        guard let moduleConfig = moduleConfig else {
            return []
        }
        return try customEnums.map {
            let fileName = baseConfig.language.getFinalName(name: "\($0.name)_\(moduleConfig.namingPostfix).\(baseConfig.language.fileExtension)",
                needCapitalizeFirst: true)
            return FileContext(
                filePath: moduleConfig.outputFolderPath + Path(fileName),
                templateFilePath: moduleConfig.templateFilePath,
                context: try CustomEnumRawMapper(model: $0, moduleConfig: moduleConfig, baseConfig: baseConfig, parameterMapper: nil).toRaw()
            )
        }
    }

}
