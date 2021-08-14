//
//  SpreadsheetUserPropetiesParser.swift
//  
//
//  Created by Alexander Filimonov on 04/09/2020.
//

final class SpreadsheetUserPropetiesParser {

    // MARK: - Private Properties

    private let spreadsheet: Spreadsheet

    // MARK: - Initialization

    init(spreadsheet: Spreadsheet) {
        self.spreadsheet = spreadsheet
    }

    // MARK: - Public Methods

    public func parse() -> [UserProperty] {
        var userPoperties: [UserProperty] = []

        for row in spreadsheet.values {
            let currentUserPropertyName = row[safe: 0]?.nilIfEmpty()
            let currentUserPropertyDescription = row[safe: 1]?.nilIfEmpty()
            let currentParameterType = row[safe: 2]?.nilIfEmpty()

            guard
                let userPropertyNameUnwrapped = currentUserPropertyName,
                let parameterTypeUnwrapped = currentParameterType
            else {
                continue
            }

            userPoperties.append(
                UserProperty(
                    name: userPropertyNameUnwrapped,
                    description: currentUserPropertyDescription,
                    type: .init(raw: parameterTypeUnwrapped)
                )
            )

        }

        return userPoperties
    }

}
