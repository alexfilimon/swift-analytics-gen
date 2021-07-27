//
//  SwiftLanguage.swift
//  
//
//  Created by Alexander Filimonov on 14/03/2020.
//

public struct SwiftLanguage: Language {

    // MARK: - LanguageProtocol

    public var rawName: String {
        return "swift"
    }
    public var fileExtension: String {
        return "swift"
    }

    public func getDefaultParameterTypeName(by parameterType: ParameterType) -> String? {
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

    public func getFinalName(name: String, needCapitalizeFirst: Bool) -> String {
        return name.snackToCamel(capitalizingFirst: needCapitalizeFirst)
    }

}
