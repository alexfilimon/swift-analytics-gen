//
//  UserPropertyRawMapper.swift
//  
//
//  Created by Alexander Filimonov on 04/09/2020.
//

import Foundation

final class UserPropertyRawMapper: RawMapper<UserProperty> {

    override public func toRaw() throws -> [String : Any] {
        return [
            "name": baseConfig.language.getFinalName(
                name: model.name,
                needCapitalizeFirst: false
            ),
            "raw_name": model.name,
            "description": model.description as Any,
            "parameter": (try parameterMapper?.map(parameterType: model.type)) ?? [:]
        ]
    }

}
