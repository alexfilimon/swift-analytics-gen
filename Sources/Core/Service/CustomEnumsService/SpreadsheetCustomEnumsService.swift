//
//  SpreadsheetCustomEnumsService.swift
//  
//
//  Created by Alexander Filimonov on 14/03/2020.
//

import NetworkService
import PathKit

public final class SpreadsheetCustomEnumsService: CustomEnumsAbstractService {

    // MARK: - Private Properties

    private let spreadsheetService: GoogleSpreadsheetAbstractService
    private let spreadsheetConfig: SpreadsheetConfig?

    // MARK: - Initialization

    public init(creadentialFilePath: Path,
                spreadsheetConfig: SpreadsheetConfig?) throws {
        self.spreadsheetService = try GoogleSpreadsheetService(creadentialFilePath: creadentialFilePath)
        self.spreadsheetConfig = spreadsheetConfig
    }

    // MARK: - CustomEnumsAbstractService

    public func getCustomEnums() throws -> [CustomEnum] {
        guard let spreadsheetConfig = spreadsheetConfig else {
            return []
        }
        let requestEntiry = SpreadsheetRequestEntity(id: spreadsheetConfig.id,
                                                     pageName: spreadsheetConfig.pageName,
                                                     range: spreadsheetConfig.range)
        let spreadsheetEntry = try spreadsheetService.getGoogleSheetData(by: requestEntiry)
        return SpreadsheetCustomEnumParser(spreadsheet: .init(from: spreadsheetEntry)).getCustomEnums()
    }

}
