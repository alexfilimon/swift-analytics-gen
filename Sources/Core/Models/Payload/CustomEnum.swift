//
//  CustomEnum.swift
//  
//
//  Created by Alexander Filimonov on 01/03/2020.
//

public struct CustomEnum: Equatable {

    // MARK: - Public Properties

    public let name: String
    public let description: String?
    public let variants: [CustomEnumVariant]

    // MARK: - Initialization

    public init(name: String,
                description: String?,
                variants: [CustomEnumVariant]) {
        self.name = name
        self.description = description
        self.variants = variants
    }

}
