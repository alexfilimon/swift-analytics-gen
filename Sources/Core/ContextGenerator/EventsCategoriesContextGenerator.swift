//
//  EventsCategoriesContextGenerator.swift
//  
//
//  Created by Alexander Filimonov on 06/03/2020.
//

import Foundation
import Models
import PathKit

public final class EventsCategoriesContextGenerator {

    // MARK: - Private Properties

    private let config: Config
    private let payload: Payload

    // MARK: - Initialization

    public init(config: Config,
                payload: Payload) {
        self.config = config
        self.payload = payload
    }

    // MARK: - Public Methods

    public func generate() throws -> [FileContext] {
        return try payload.eventsCategories.map { try getFileGenerator(by: $0) }
    }

}

// MARK: - Private Methods

private extension EventsCategoriesContextGenerator {

    func getFileGenerator(by eventCategory: EventCategory) throws -> FileContext {
        return .init(filePath: getFilePath(by: eventCategory),
                     context: try EventCategoryRawMapper(model: eventCategory, config: config, payload: payload).toRaw())
    }

    func getFilePath(by eventCategory: EventCategory) -> Path {
        let categoryName = "\(eventCategory.name)_\(config.eventsModuleConfig.namingPostfix)".snackToCamel(capitalizingFirst: true)
        let fileName = categoryName + "." + config.language.fileExtension
        return config.eventsModuleConfig.outputFolderPath + Path(fileName.capitalizingFirstLetter())
    }

}
