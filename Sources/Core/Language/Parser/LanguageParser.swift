//
//  LanguageParser.swift
//  
//
//  Created by Alexander Filimonov on 14/03/2020.
//

public final class LanguageParser {

    // MARK: - Pirvate Methods

    private let rawName: String

    // MARK: - Inialization

    public init(rawName: String) {
        self.rawName = rawName
    }

    // MARK: - Public Methods

    public func parse() throws -> Language {
        guard let language = AllLanguages.list.first(where: { $0.rawName == rawName }) else {
            throw LanguageParserError.unknownLanguage(rawName)
        }
        return language
    }

}
