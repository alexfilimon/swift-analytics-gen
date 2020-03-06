//
//  ParameterRawMapper.swift
//  
//
//  Created by Alexander Filimonov on 06/03/2020.
//

import Foundation
import Models

public final class ParameterRawMapper: RawMapper<Parameter> {

    public override func toRaw() throws -> [String : Any] {
        return [
            "name": model.name.snackToCamel(capitalizingFirst: false),
            "description": model.description as Any,
            "type": try ParameterTypeRawMapper(model: model.type,
                                                    config: config,
                                                    payload: payload).toRaw().values.first as Any
        ]
    }

}
