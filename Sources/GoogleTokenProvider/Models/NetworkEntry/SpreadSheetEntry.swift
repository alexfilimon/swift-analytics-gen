//
//  SpreadSheetEntry.swift
//  
//
//  Created by Alexander Filimonov on 01/03/2020.
//

import Foundation

public struct SpreadSheetEntry: Decodable {
    let range: String
    let majorDimension: String
    let values: [[String]]
}
