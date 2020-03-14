//
//  CustomEnumVariantRawMapper.swift
//  
//
//  Created by Alexander Filimonov on 06/03/2020.
//

import Foundation

/// Class for translating customEnumVariant to raw representation
public final class CustomEnumVariantRawMapper: RawMapper<CustomEnumVariant> {

    override public func toRaw() throws -> [String : Any] {
        return [
            "name": model.name.snackToCamel(capitalizingFirst: false),
            "description": model.description as Any,
            "raw_value": model.name
        ]
    }

}
