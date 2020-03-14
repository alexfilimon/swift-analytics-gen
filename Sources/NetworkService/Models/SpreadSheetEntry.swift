//
//  SpreadSheetEntry.swift
//  
//
//  Created by Alexander Filimonov on 01/03/2020.
//

import Foundation

public struct SpreadSheetEntry: Decodable {
    public let range: String
    public let majorDimension: String
    public let values: [[String]]
}
