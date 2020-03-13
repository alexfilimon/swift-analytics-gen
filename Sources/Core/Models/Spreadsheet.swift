//
//  File.swift
//  
//
//  Created by Alexander Filimonov on 13/03/2020.
//

import Service

public struct Spreadsheet {

    // MARK: - Public Properties

    public let range: String
    public let majorDimension: String
    public let values: [[String]]

    // MARK: - Initialization

    init(from entry: SpreadSheetEntry) {
        self.range = entry.range
        self.majorDimension = entry.majorDimension
        self.values = entry.values
    }

    public init(range: String,
                majorDimension: String,
                values: [[String]]) {
        self.range = range
        self.majorDimension = majorDimension
        self.values = values
    }

}
