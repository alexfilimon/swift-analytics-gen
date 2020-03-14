//
//  AllLanguages.swift
//  
//
//  Created by Alexander Filimonov on 14/03/2020.
//

public enum AllLanguages {

    static var list: [Language] {
        return [
            SwiftLanguage(),
            KotlinLanguage()
        ]
    }

}
