//
//  Array.swift
//  
//
//  Created by Alexander Filimonov on 01/03/2020.
//

import Foundation

public extension Array {

    /// Method for safe subscripting array
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }

}
