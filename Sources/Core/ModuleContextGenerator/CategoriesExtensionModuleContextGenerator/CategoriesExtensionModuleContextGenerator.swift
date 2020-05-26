//
//  CategoriesExtensionModuleContextGenerator.swift
//  
//
//  Created by Alexander Filimonov on 14/03/2020.
//

import PathKit

public final class CategoriesExtensionModuleContextGenerator: ModuleContextGenerator {

    // MARK: - Private Properties

    private let categories: [EventCategory]
    private let categoriesExtensionTemplatePath: Path
    private let categoriesExtensionOutputPath: Path
    private let language: Language
    private let namePostfix: String

    // MARK: - Initializaion

    public init(categories: [EventCategory],
                categoriesExtensionTemplatePath: Path,
                categoriesExtensionOutputPath: Path,
                language: Language,
                namePostfix: String) {
        self.categories = categories
        self.categoriesExtensionTemplatePath = categoriesExtensionTemplatePath
        self.categoriesExtensionOutputPath = categoriesExtensionOutputPath
        self.language = language
        self.namePostfix = namePostfix
    }

    // MARK: - ModuleContextGenerator

    public func generate() throws -> [FileContext] {
        let categoriesRaw = try CategoryExtensionEventCategoryMapper(categories: categories,
                                                                     language: language,
                                                                     namePostfix: namePostfix).toRaw()
        let fileName = language.getFinalName(
            name: "analytics_categories_extension.\(language.fileExtension)",
            needCapitalizeFirst: true
        )
        let context = FileContext(
            filePath: categoriesExtensionOutputPath + Path(fileName),
            templateFilePath: categoriesExtensionTemplatePath,
            context: categoriesRaw
        )
        return [context]
    }

}
