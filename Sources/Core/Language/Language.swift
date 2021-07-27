//
//  LanguageProtocol.swift
//  
//
//  Created by Alexander Filimonov on 13/03/2020.
//

/// Protocol for describing language
public protocol Language {

    /// name for config
    var rawName: String { get }

    /// name of file extension
    var fileExtension: String { get }

    /// default parameter's name
    func getDefaultParameterTypeName(by parameterType: ParameterType) -> String?

    /// name for some class or method
    func getFinalName(name: String, needCapitalizeFirst: Bool) -> String

    /// name for custom enum
    func getCustomEnumName(name: String) -> String

    /// name for file with extension
    func getFileName(name: String) -> String

}

public extension Language {

    func getCustomEnumName(name: String) -> String {
        return self.getFinalName(name: name, needCapitalizeFirst: true)
    }

    func getFileName(name: String) -> String {
        return "\(getFinalName(name: name, needCapitalizeFirst: true)).\(self.fileExtension)"
    }

}
