//
//  EventCategoryRawMapper.swift
//  
//
//  Created by Alexander Filimonov on 06/03/2020.
//

import Foundation

final class EventCategoryRawMapper: RawMapper<EventCategory> {

    override public func toRaw() throws -> [String : Any] {
        return [
            "name": baseConfig.language.getFinalName(name: "\(model.name)_\(moduleConfig.namingPostfix)", needCapitalizeFirst: true),
            "description": model.description as Any,
            "events": try model.events.filter { $0.shouldGenerate }.map {
                try EventRawMapper(model: $0, moduleConfig: moduleConfig, baseConfig: baseConfig, parameterMapper: parameterMapper).toRaw()
            }
        ]
    }

}
