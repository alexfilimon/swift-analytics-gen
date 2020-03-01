//
//  SpreadsheetEventsParser.swift
//  
//
//  Created by Alexander Filimonov on 01/03/2020.
//

import Foundation
import GoogleService
import Core
import Models

final class SpreadsheetEventsParser {

    // MARK: - Private Properties

    private let spreadsheet: SpreadSheetEntry

    // MARK: - Initialization

    init(spreadsheet: SpreadSheetEntry) {
        self.spreadsheet = spreadsheet
    }

    // MARK: - Public Methods

    func getEvents() -> [EventCategory] {
        var categories: [EventCategory] = []

        var category: EventCategory?
        var event: Event?
        var parameter: Parameter?

        for row in spreadsheet.values {
            let currentCategoryName = row[safe: 0] ?? ""
            let currentEventName = row[safe: 1] ?? ""
            let currentEventDescription = row[safe: 2]
            let currentParameterName = row[safe: 3] ?? ""
            let currentParameterType = row[safe: 4] ?? ""
            let currentParameterDescription = row[safe: 5]

            if !currentCategoryName.isEmpty {
                if let parameterUnwrapped = parameter, let eventUnwrapped = event {
                    event = .init(name: eventUnwrapped.name,
                                  description: eventUnwrapped.description,
                                  parameters: eventUnwrapped.parameters + [parameterUnwrapped])
                    parameter = nil
                }
                if let eventUnwrapped = event, let categoryUnwrapped = category {
                    category = .init(name: categoryUnwrapped.name,
                                     description: categoryUnwrapped.description,
                                     events: categoryUnwrapped.events + [eventUnwrapped])
                    event = nil
                }
                if let categoryUnwrapped = category {
                    categories.append(categoryUnwrapped)
                    category = nil
                }
                category = .init(name: currentCategoryName,
                                 description: nil,
                                 events: [])
            }

            if !currentEventName.isEmpty {
                if let parameterUnwrapped = parameter, let eventUnwrapped = event {
                    event = .init(name: eventUnwrapped.name,
                                  description: eventUnwrapped.description,
                                  parameters: eventUnwrapped.parameters + [parameterUnwrapped])
                    parameter = nil
                }
                if let eventUnwrapped = event, let categoryUnwrapped = category {
                    category = .init(name: categoryUnwrapped.name,
                                     description: categoryUnwrapped.description,
                                     events: categoryUnwrapped.events + [eventUnwrapped])
                    event = nil
                }
                event = .init(name: currentEventName,
                              description: currentEventDescription,
                              parameters: [])
            }

            if !currentParameterName.isEmpty {
                if let parameterUnwrapped = parameter, let eventUnwrapped = event {
                    event = .init(name: eventUnwrapped.name,
                                  description: eventUnwrapped.description,
                                  parameters: eventUnwrapped.parameters + [parameterUnwrapped])
                    parameter = nil
                }
                parameter = .init(name: currentParameterName,
                                  description: currentEventDescription,
                                  type: .init(raw: currentParameterType))
            }

        }

        if let parameterUnwrapped = parameter, let eventUnwrapped = event {
            event = .init(name: eventUnwrapped.name,
                          description: eventUnwrapped.description,
                          parameters: eventUnwrapped.parameters + [parameterUnwrapped])
            parameter = nil
        }
        if let eventUnwrapped = event, let categoryUnwrapped = category {
            category = .init(name: categoryUnwrapped.name,
                             description: categoryUnwrapped.description,
                             events: categoryUnwrapped.events + [eventUnwrapped])
            event = nil
        }
        if let categoryUnwrapped = category {
            categories.append(categoryUnwrapped)
            category = nil
        }

        return categories
    }

}
