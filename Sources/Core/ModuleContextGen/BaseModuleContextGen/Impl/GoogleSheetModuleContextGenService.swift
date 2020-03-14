//
//  GoogleSheetModuleContextGenService.swift
//  
//
//  Created by Alexander Filimonov on 13/03/2020.
//

import NetworkService
import PathKit

public final class GoogleSheetModuleContextGenService: ModuleContextGeneratorService<Spreadsheet> {

    // MARK: - Private Properties

    private let creadentialFilePath: Path
    private let spreadsheetRequest: SpreadsheetConfig

    // MARK: - Initialization

    public init(creadentialFilePath: Path,
                spreadsheetRequest: SpreadsheetConfig) {
        self.creadentialFilePath = creadentialFilePath
        self.spreadsheetRequest = spreadsheetRequest
    }

    // MARK: - ModuleContextGeneratorService

    public override func getPayload() throws -> Spreadsheet {
        let spreadheetRequestModel = SpreadsheetRequestEntity(id: spreadsheetRequest.id,
                                                              pageName: spreadsheetRequest.pageName,
                                                              range: spreadsheetRequest.range)
        let entry = try GoogleSpreadsheetService(creadentialFilePath: creadentialFilePath).getGoogleSheetData(by: spreadheetRequestModel)
        return .init(from: entry)
    }

}
