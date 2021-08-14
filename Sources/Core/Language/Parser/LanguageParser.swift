//
//  LanguageParser.swift
//  
//
//  Created by Alexander Filimonov on 14/03/2020.
//

/// Language parser - to get language from rawName
public final class LanguageParser {

    // MARK: - Pirvate Methods

    private let rawName: String

    // MARK: - Inialization

    /// Initializer for parser
    /// - Parameter rawName: rawName of language
    public init(rawName: String) {
        self.rawName = rawName
    }

    // MARK: - Public Methods

    /// Method for getting language by it's name
    public func parse() throws -> Language {
        guard let language = AllLanguages.list.first(where: { $0.rawName == rawName }) else {
            throw LanguageParserError.unknownLanguage(rawName)
        }
        return language
    }

}
