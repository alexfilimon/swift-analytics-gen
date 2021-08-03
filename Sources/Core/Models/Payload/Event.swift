//
//  Event.swift
//  
//
//  Created by Alexander Filimonov on 01/03/2020.
//

public struct Event: Equatable {

    // MARK: - Public Properties

    public let name: String
    public let description: String?
    public let parameters: [Parameter]
    public let shouldGenerate: Bool

    // MARK: - Initialization

    public init(name: String,
                description: String?,
                parameters: [Parameter],
                shouldGenerate: Bool) {
        self.name = name
        self.description = description
        self.parameters = parameters
        self.shouldGenerate = shouldGenerate
    }

}
