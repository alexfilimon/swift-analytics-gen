//
//  SpreadsheetPayloadParser.swift
//  
//
//  Created by Alexander Filimonov on 01/03/2020.
//

import Foundation
import GoogleTokenProvider
import GoogleService
import Core
import PathKit

public final class SpreadsheetPayloadParser: PayloadParser {

    // MARK: - Constants

    private enum Constants {
        static let authScopes: [String] = ["https://www.googleapis.com/auth/drive"]
    }

    // MARK: - Private Properties

    private let config: Config

    // MARK: - Initialization

    public init(config: Config) {
        self.config = config
    }

    // MARK: - PayloadParser

    public func getPayload() throws -> Payload {
        let eventsSpreadsheet = try getSpreadsheet(by: config.spreadsheetEventsConfig,
                                                   credentialsFilePath: config.pathConfig.credentialsFilePath)
        let cutomsEnumsSpreadsheet = try getSpreadsheet(by: config.spreadsheedCustomEnumsConfig,
                                                        credentialsFilePath: config.pathConfig.credentialsFilePath)
        return .init(eventsCategories: SpreadsheetEventsParser(spreadsheet: eventsSpreadsheet).getEvents(),
                     customEnums: SpreadsheetCustomEnumParser(spreadsheet: cutomsEnumsSpreadsheet).getCustomEnums())
    }

}

// MARK: - Private Methods

private extension SpreadsheetPayloadParser {

    func getSpreadsheet(by spreadsheetConfig: SpreadsheetConfig, credentialsFilePath: Path) throws -> SpreadSheetEntry {
        let provider = try GoogleTokenProvider(scopes: Constants.authScopes,
                                               credentialFilePath: config.pathConfig.credentialsFilePath)
        let googleSpreadsheetService = GoogleSpreadsheetService(tokenProvider: provider)
        return try googleSpreadsheetService.getGoogleSheetData(spreadsheetConfig: spreadsheetConfig)
    }

}
