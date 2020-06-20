//
//  SpreadsheetCustomEnumsService.swift
//  
//
//  Created by Alexander Filimonov on 14/03/2020.
//

import NetworkService
import PathKit
import Foundation

/// Service for getting custom enums from google spreadsheet service
public final class SpreadsheetCustomEnumsService: CustomEnumsAbstractService {

    // MARK: - Private Properties

    private let networkSpreadsheetService: GoogleSpreadsheetAbstractService
    private let spreadsheetConfig: SpreadsheetConfig?
    private let shouldLog: Bool

    // MARK: - Initialization

    public init(creadentialFilePath: Path,
                spreadsheetConfig: SpreadsheetConfig?,
                shouldLog: Bool = false) throws {
        self.networkSpreadsheetService = try GoogleSpreadsheetService(
            creadentialFilePath: creadentialFilePath,
            shouldLog: shouldLog
        )
        self.spreadsheetConfig = spreadsheetConfig
        self.shouldLog = shouldLog
    }

    // MARK: - CustomEnumsAbstractService

    public func getCustomEnums() throws -> [CustomEnum] {
        guard let spreadsheetConfig = spreadsheetConfig else {
            return []
        }
        logIfNeeded("Preparing network request")
        let requestEntiry = SpreadsheetNetworkRequestEntity(id: spreadsheetConfig.id,
                                                            pageName: spreadsheetConfig.pageName,
                                                            range: spreadsheetConfig.range)
        logIfNeeded("Making network request")
        let spreadsheetEntry = try networkSpreadsheetService.getGoogleSheetData(by: requestEntiry)
        logIfNeeded("Parsing network response")
        return SpreadsheetCustomEnumParser(spreadsheet: .init(from: spreadsheetEntry)).getCustomEnums()
    }

}

// MARK: - Private Properties

private extension SpreadsheetCustomEnumsService {

    func logIfNeeded(_ string: String) {
        guard shouldLog else { return }
        print("\(Date()) [SpreadsheetCustomEnumsService]: \(string)")
    }

}
