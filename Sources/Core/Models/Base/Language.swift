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

    // MARK: - Initialization

    public init(raw: String) throws {
        switch raw {
        case "swift":
            self = .swift
        case "kotlin":
            self = .kotlin
        default:
            throw LanguageError.unknownLanguage(raw)
        }
    }

    // MARK: - Public Properties

    public var fileExtension: String {
        switch self {
        case .swift:
            return "swift"
        case .kotlin:
            return "kt"
        }
    }

    public func getDefaultParameterType(by parameterType: ParameterType) -> String? {
        switch self {
        case .kotlin:
            return KotlinTypeDetector.getDefaultParameterType(by: parameterType)
        case .swift:
            return SwiftTypeDetector.getDefaultParameterType(by: parameterType)
        }
    }

}

private enum KotlinTypeDetector {

    static func getDefaultParameterType(by parameterType: ParameterType) -> String? {
        switch parameterType {
        case .date:
            return "date"
        case .int:
            return "int"
        case .double:
            return "double"
        case .bool:
            return "bool"
        case .string:
            return "string"
        case .customEnum:
            return nil
        }
    }

}

private enum SwiftTypeDetector {

    static func getDefaultParameterType(by parameterType: ParameterType) -> String? {
        switch parameterType {
        case .date:
            return "Date"
        case .int:
            return "Int"
        case .double:
            return "Double"
        case .bool:
            return "Bool"
        case .string:
            return "String"
        case .customEnum:
            return nil
        }
    }

}
