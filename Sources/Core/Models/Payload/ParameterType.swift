//
//  ParameterType.swift
//  
//
//  Created by Alexander Filimonov on 01/03/2020.
//

import Foundation

public enum ParameterType {
    case date
    case int
    case double
    case bool
    case string
    case customEnum(name: String)

    // MARK: - Initialization

    public init(raw: String) {
        switch raw.lowercased() {
        case "date":
            self = .date
        case "int":
            self = .int
        case "double":
            self = .double
        case "bool":
            self = .bool
        case "string":
            self = .string
        default:
            self = .customEnum(name: raw)
        }
    }

    public func stringValue() -> String {
        switch self {
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
        case .customEnum(let name):
            return name
        }
    }

}
