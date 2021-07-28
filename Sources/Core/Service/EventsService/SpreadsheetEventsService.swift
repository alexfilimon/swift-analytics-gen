//
//  SpreadsheetEventsService.swift
//  
//
//  Created by Alexander Filimonov on 14/03/2020.
//

import NetworkService
import PathKit
import Foundation

public final class SpreadsheetEventsService: EventsAbstractService {

    // MARK: - Pirvate Properties

    private let networkSpreadsheetService: GoogleSpreadsheetAbstractService
    private let spreadsheetConfig: SpreadsheetConfig
    private let shouldLog: Bool

    // MARK: - Initialization

    public init(creadentialFilePath: Path,
                spreadsheetConfig: SpreadsheetConfig,
                shouldLog: Bool = false) throws {
        self.networkSpreadsheetService = try GoogleSpreadsheetService(
            creadentialFilePath: creadentialFilePath,
            shouldLog: shouldLog
        )
        self.spreadsheetConfig = spreadsheetConfig
        self.shouldLog = shouldLog
    }

    // MARK: - EventsAbstractService

    public func getEvents() throws -> [EventCategory] {
        logIfNeeded("Preparing network request")
        let requestEntity = SpreadsheetNetworkRequestEntity(id: spreadsheetConfig.id,
                                                            pageName: spreadsheetConfig.pageName,
                                                            range: spreadsheetConfig.range)
        logIfNeeded("Making network request")
        let spreadsheetEntry = try networkSpreadsheetService.getGoogleSheetData(by: requestEntity)
        logIfNeeded("Parsing network response")
        return SpreadsheetEventsParser(spreadsheet: .init(from: spreadsheetEntry)).parse()
    }

}

// MARK: - Private Properties

private extension SpreadsheetEventsService {

    func logIfNeeded(_ string: String) {
        guard shouldLog else { return }
        print("\(Date()) [SpreadsheetEventsService]: \(string)")
    }

}
