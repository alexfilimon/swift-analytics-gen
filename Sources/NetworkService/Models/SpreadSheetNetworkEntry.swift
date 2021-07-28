//
//  SpreadSheetEntry.swift
//  
//
//  Created by Alexander Filimonov on 01/03/2020.
//

/// Spreadsheet DTO
public struct SpreadSheetNetworkEntry: Decodable {
    
    // MARK: - Public Properties
    
    public let range: String
    public let majorDimension: String
    public let values: [[String]]

}
