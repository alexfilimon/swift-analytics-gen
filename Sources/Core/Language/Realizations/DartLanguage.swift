//
//  File.swift
//  
//
//  Created by Alexander Filimonov on 04/09/2020.
//

public struct DartLanguage: Language {

    // MARK: - LanguageProtocol

    public var rawName: String {
        return "dart"
    }
    public var fileExtension: String {
        return "dart"
    }

    public func getDefaultParameterTypeName(by parameterType: ParameterType) -> String? {
        switch parameterType {
        case .date:
            return "DateTime"
        case .int:
            return "int"
        case .double:
            return "double"
        case .bool:
            return "bool"
        case .string:
            return "String"
        case .customEnum:
            return nil
        }
    }

    public func getFinalName(name: String, needCapitalizeFirst: Bool) -> String {
        return name.snackToCamel(capitalizingFirst: needCapitalizeFirst)
    }

    public func getFileName(name: String) -> String {
        return "\(name).\(self.fileExtension)"
    }

}
