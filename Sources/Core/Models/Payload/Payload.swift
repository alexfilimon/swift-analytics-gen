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
    public let userProperties: [String]

    // MARK: - Initialization

    public init(eventsCategories: [EventCategory],
                customEnums: [CustomEnum],
                userProperties: [String] = []) {
        self.eventsCategories = eventsCategories
        self.customEnums = customEnums
        self.userProperties = userProperties
    }

}
