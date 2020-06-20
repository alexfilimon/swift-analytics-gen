//
//  EventRawMapper.swift
//  
//
//  Created by Alexander Filimonov on 06/03/2020.
//

import Foundation

final class EventRawMapper: RawMapper<Event> {

    override public func toRaw() throws -> [String : Any] {
        return [
            "name": model.name.snackToCamel(capitalizingFirst: false),
            "raw_name": model.name,
            "description": model.description as Any,
            "parameters": try model.parameters.compactMap { try parameterMapper?.map(parameter: $0) }
        ]
    }

}
