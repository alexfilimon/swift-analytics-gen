//
//  Payload.swift
//  
//
//  Created by Alexander Filimonov on 01/03/2020.
//

import Foundation

public struct Payload {

    // MARK: - Public Properties

    public let eventsCategories: [EventCategory]
    public let customEnums: [CustomEnum]

    // MARK: - Initialization

    public init(eventsCategories: [EventCategory],
                customEnums: [CustomEnum]) {
        self.eventsCategories = eventsCategories
        self.customEnums = customEnums
    }

}
