//
//  CustomEnumNameManager.swift
//  
//
//  Created by Alexander Filimonov on 06/03/2020.
//

import Foundation

public final class CustomEnumNameManager {

    // MARK: - Private Properites

    private let customEnum: CustomEnum
    private let customEnumsConfig: ModuleConfig

    // MARK: - Initialization

    public init(customEnum: CustomEnum,
                customEnumsConfig: ModuleConfig) {
        self.customEnum = customEnum
        self.customEnumsConfig = customEnumsConfig
    }

    // MARK: - Public Methods

    public func getName() -> String {
        return "\(customEnum.name)_\(customEnumsConfig.namingPostfix)".snackToCamel(capitalizingFirst: true)
    }

}
