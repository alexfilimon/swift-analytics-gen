//
//  Language.swift
//  
//
//  Created by Alexander Filimonov on 01/03/2020.
//

import Foundation

public enum Language {
    case swift
    case kotlin

    // MARK: - Public Properties

    public var fileExtension: String {
        switch self {
        case .swift:
            return "swift"
        case .kotlin:
            return "kt"
        }
    }

}
