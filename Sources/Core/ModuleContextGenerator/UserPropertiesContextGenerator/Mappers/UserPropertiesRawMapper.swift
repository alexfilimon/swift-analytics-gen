//
//  UserPropertiesRawMapper.swift
//  
//
//  Created by Alexander Filimonov on 11/09/2020.
//

import Foundation

final class UserPropertiesRawMapper: RawMapper<[UserProperty]> {

    override public func toRaw() throws -> [String : Any] {
        return [
            "name": baseConfig.language.getFinalName(
                name: moduleConfig.namingPostfix,
                needCapitalizeFirst: true
            ),
            "user_properties": try model.map {
                try UserPropertyRawMapper(
                    model: $0,
                    moduleConfig: moduleConfig,
                    baseConfig: baseConfig,
                    parameterMapper: parameterMapper
                ).toRaw()
            }
        ]
    }

}
