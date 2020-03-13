//
//  EventCategory.swift
//  
//
//  Created by Alexander Filimonov on 01/03/2020.
//

import Foundation

public struct EventCategory: Equatable {

    // MARK: - Public Properties

    public let name: String
    public let description: String?
    public let events: [Event]

    // MARK: - Initialization

    public init(name: String,
                description: String?,
                events: [Event]) {
        self.name = name
        self.description = description
        self.events = events
    }

}
