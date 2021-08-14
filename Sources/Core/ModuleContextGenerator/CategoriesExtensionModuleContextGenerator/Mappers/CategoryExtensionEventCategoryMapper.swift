//
//  CategoryExtensionEventCategoryMapper.swift
//  
//
//  Created by Alexander Filimonov on 14/03/2020.
//

public final class CategoryExtensionEventCategoryMapper: RawMappable {

    // MARK: - Private Properties

    private let categories: [EventCategory]
    private let language: Language
    private let namePostfix: String

    // MARK: - Initialization

    public init(categories: [EventCategory],
                language: Language,
                namePostfix: String) {
        self.categories = categories
        self.language = language
        self.namePostfix = namePostfix
    }

    // MARK: - RawMappable

    public func toRaw() throws -> [String : Any] {
        return [
            "categories": categories.map { category in
                let fullCategoryName = "\(category.name)_\(namePostfix)"
                return [
                    "short_name": language.getFinalName(name: category.name, needCapitalizeFirst: false),
                    "full_name": language.getFinalName(name: fullCategoryName, needCapitalizeFirst: true)
                ]
            } as [[String: Any]]
        ]
    }

}
