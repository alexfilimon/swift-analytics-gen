//
//  String.swift
//  
//
//  Created by Alexander Filimonov on 06/03/2020.
//

import Foundation

public extension String {

    /// Method for capitalizing only first letter
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    /// Method for modifying string from snack_case to camelCase
    /// - Parameter capitalizingFirst: boolean flag, that indicates if need capitalize first letter
    func snackToCamel(capitalizingFirst: Bool) -> String {
        let components = self.split(separator: "_")
        let componentsCalitalized = components.map { String($0).lowercased().capitalizingFirstLetter() }
        if capitalizingFirst {
            return componentsCalitalized.joined()
        }
        guard let first = components.first else {
            return ""
        }
        let newComponents = [first.lowercased()] + componentsCalitalized.dropFirst()
        return newComponents.joined()
    }

    /// Method that returns nil if string isEmpty
    func nilIfEmpty() -> String? {
        return isEmpty ? nil : self
    }

    /// Method that converts string to bool
    func boolValue() -> Bool? {
        if self.lowercased() == "true" {
            return true
        } else if self.lowercased() == "false" {
            return false
        } else {
            return nil
        }
    }

}
