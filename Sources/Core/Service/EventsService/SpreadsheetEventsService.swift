//
//  SpreadsheetEventsService.swift
//  
//
//  Created by Alexander Filimonov on 14/03/2020.
//

import NetworkService
import PathKit

public final class SpreadsheetEventsService: EventsAbstractService {

    // MARK: - Pirvate Properties

    private let networkSpreadsheetService: GoogleSpreadsheetAbstractService
    private let spreadsheetConfig: SpreadsheetConfig

    // MARK: - Initialization

    public init(creadentialFilePath: Path,
                spreadsheetConfig: SpreadsheetConfig) throws {
        self.networkSpreadsheetService = try GoogleSpreadsheetService(creadentialFilePath: creadentialFilePath)
        self.spreadsheetConfig = spreadsheetConfig
    }

    // MARK: - EventsAbstractService

    public func getEvents() throws -> [EventCategory] {
        let requestEntity = SpreadsheetNetworkRequestEntity(id: spreadsheetConfig.id,
                                                     pageName: spreadsheetConfig.pageName,
                                                     range: spreadsheetConfig.range)
        let spreadsheetEntry = try networkSpreadsheetService.getGoogleSheetData(by: requestEntity)
        return SpreadsheetEventsParser(spreadsheet: .init(from: spreadsheetEntry)).parse()
    }

}
