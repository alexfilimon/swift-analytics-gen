//
//  AllLanguages.swift
//  
//
//  Created by Alexander Filimonov on 14/03/2020.
//

/// Constant for returning all available languages
public enum AllLanguages {

    static var list: [Language] {
        return [
            SwiftLanguage(),
            KotlinLanguage(),
            DartLanguage()
        ]
    }

}
