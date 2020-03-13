//
//  EventCategoryRawMapper.swift
//  
//
//  Created by Alexander Filimonov on 06/03/2020.
//

import Foundation

public final class EventCategoryRawMapper: RawMapper<EventCategory> {

    override public func toRaw() throws -> [String : Any] {
        return [
            "name": "\(model.name)_\(config.eventsModuleConfig.namingPostfix)".snackToCamel(capitalizingFirst: true),
            "description": model.description as Any,
            "events": try model.events.map { try EventRawMapper(model: $0, config: config, payload: payload).toRaw() }
        ]
    }

}
