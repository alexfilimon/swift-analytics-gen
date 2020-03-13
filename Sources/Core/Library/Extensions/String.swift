//
//  String.swift
//  
//
//  Created by Alexander Filimonov on 06/03/2020.
//

import Foundation

public extension String {

    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

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

    func nilIfEmpty() -> String? {
        return isEmpty ? nil : self
    }

}
