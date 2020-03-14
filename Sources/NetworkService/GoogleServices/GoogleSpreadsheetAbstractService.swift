//
//  GoogleSpreadsheetAbstractService.swift
//  
//
//  Created by Alexander Filimonov on 13/03/2020.
//

public protocol GoogleSpreadsheetAbstractService {
    /// Method for getting content in table
    /// - Parameters:
    ///   - spreadsheetConfig: entity for getting spreadsheet
    func getGoogleSheetData(by spreadsheetConfig: SpreadsheetNetworkRequestEntity) throws -> SpreadSheetNetworkEntry
}
