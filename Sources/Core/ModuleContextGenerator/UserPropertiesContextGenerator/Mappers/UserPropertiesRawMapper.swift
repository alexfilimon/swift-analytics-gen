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
