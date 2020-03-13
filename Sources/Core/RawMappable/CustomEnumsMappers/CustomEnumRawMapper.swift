//
//  CustomEnumRawMapper.swift
//  
//
//  Created by Alexander Filimonov on 06/03/2020.
//

import Foundation
import Models

public final class CustomEnumRawMapper: RawMapper<CustomEnum> {

    override public func toRaw() throws -> [String : Any] {
        return [
            "name": CustomEnumNameManager(customEnum: model, customEnumsConfig: config.customEnumModuleConfig).getName(),
            "description": model.description as Any,
            "variants": try model.variants.map { try CustomEnumVariantRawMapper(model: $0, config: config, payload: payload).toRaw() }
        ]
    }

}
