//
//  SpreadsheetRequestEntity.swift
//  
//
//  Created by Alexander Filimonov on 13/03/2020.
//

public struct SpreadsheetNetworkRequestEntity {

    // MARK: - Public Properties

    public let id: String
    public let pageName: String
    public let range: String

    // MARK: - Initialization

    public init(id: String,
                pageName: String,
                range: String) {
        self.id = id
        self.pageName = pageName
        self.range = range
    }

}
