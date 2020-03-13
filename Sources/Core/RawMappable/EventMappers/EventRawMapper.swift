//
//  EventRawMapper.swift
//  
//
//  Created by Alexander Filimonov on 06/03/2020.
//

import Foundation
import Models

public final class EventRawMapper: RawMapper<Event> {

    override public func toRaw() throws -> [String : Any] {
        return [
            "name": model.name.snackToCamel(capitalizingFirst: false),
            "description": model.description as Any,
            "parameters": try model.parameters.map { try ParameterRawMapper(model: $0, config: config, payload: payload).toRaw() }
        ]
    }

}
