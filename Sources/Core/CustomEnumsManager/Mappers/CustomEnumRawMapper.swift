//
//  CustomEnumRawMapper.swift
//  
//
//  Created by Alexander Filimonov on 06/03/2020.
//

import Foundation

/// Class for translating customEnum to raw representation
public final class CustomEnumRawMapper: RawMapper<CustomEnum> {

    override public func toRaw() throws -> [String : Any] {
        return [
            "name": baseConfig.language.getCustomEnumName(name: "\(model.name)_\(moduleConfig.namingPostfix)"),
            "description": model.description as Any,
            "variants": try model.variants.map {
                try CustomEnumVariantRawMapper(model: $0, moduleConfig: moduleConfig, baseConfig: baseConfig, parameterMapper: parameterMapper).toRaw()
            }
        ]
    }

}
