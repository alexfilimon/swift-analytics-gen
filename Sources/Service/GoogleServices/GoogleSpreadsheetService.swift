//
//  GoogleSpreadsheetService.swift.swift
//  
//
//  Created by Alexander Filimonov on 01/03/2020.
//

import Foundation
import GoogleTokenProvider
import Connection

/// Class for communicating with google spreadsheet api
public final class GoogleSpreadsheetService {

    // MARK: - Private Properties

    private let connection: Connection

    // MARK: - Initialization

    /// Base initialization
    /// - Parameter tokenProvider: token provider for authorization
    public init(tokenProvider: TokenProvider) {
        self.connection = .init(tokenProvider: tokenProvider)
    }

    // MARK: - Methods

    /// Method for getting content in table
    /// - Parameters:
    ///   - spreadSheetId: identifier of spreadsheet
    ///   - pageId: page identifier (page name, must be without spaces)
    ///   - range: range in page
    public func getGoogleSheetData(spreadsheetConfig: SpreadsheetRequestEntity) throws -> SpreadSheetEntry {
        let id = spreadsheetConfig.id
        let pageName = spreadsheetConfig.pageName
        let range = spreadsheetConfig.range
        let urlString = "https://sheets.googleapis.com/v4/spreadsheets/\(id)/values/\(pageName)!\(range)"
        return try connection.performRequest(urlString: urlString, method: .get)
    }

}
