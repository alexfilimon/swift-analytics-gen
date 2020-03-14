//
//  LanguageProtocol.swift
//  
//
//  Created by Alexander Filimonov on 13/03/2020.
//

/// Protocol for describing language
public protocol Language {
    var rawName: String { get }
    var fileExtension: String { get }
    func getDefaultParameterTypeName(by parameterType: ParameterType) -> String?
    func getFinalName(name: String, needCapitalizeFirst: Bool) -> String
}
