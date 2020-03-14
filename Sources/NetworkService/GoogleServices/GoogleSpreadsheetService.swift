//
//  GoogleSpreadsheetService.swift.swift
//  
//
//  Created by Alexander Filimonov on 01/03/2020.
//

import GoogleTokenProvider
import Connection
import PathKit

/// Class for communicating with google spreadsheet api
public final class GoogleSpreadsheetService: GoogleSpreadsheetAbstractService {

    // MARK: - Constants

    private enum Constants {
        static let authScopes: [String] = ["https://www.googleapis.com/auth/drive"]
    }

    // MARK: - Private Properties

    private let connection: Connection

    // MARK: - Initialization

    /// Base initialization
    /// - Parameter tokenProvider: token provider for authorization
    public init(creadentialFilePath: Path) throws {
        let googleTokenProvider = try GoogleTokenProvider(scopes: Constants.authScopes,
                                                          credentialFilePath: creadentialFilePath)
        self.connection = .init(tokenProvider: googleTokenProvider)
    }

    // MARK: - GoogleSpreadsheetAbstractService

    public func getGoogleSheetData(by spreadsheetConfig: SpreadsheetNetworkRequestEntity) throws -> SpreadSheetNetworkEntry {
        let id = spreadsheetConfig.id
        let pageName = spreadsheetConfig.pageName
        let range = spreadsheetConfig.range
        let urlString = "https://sheets.googleapis.com/v4/spreadsheets/\(id)/values/\(pageName)!\(range)"
        return try connection.performRequest(urlString: urlString, method: .get)
    }

}
