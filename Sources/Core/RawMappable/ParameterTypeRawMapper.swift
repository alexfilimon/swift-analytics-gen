//
//  ParameterTypeRawMapper.swift
//  
//
//  Created by Alexander Filimonov on 06/03/2020.
//

import Foundation
import Models

public final class ParameterTypeRawMapper: RawMapper<ParameterType> {

    override public func toRaw() throws -> [String : Any] {
        return [
            "value": try getParatemerName()
        ]
    }

}

// MARK: - Private Methods

private extension ParameterTypeRawMapper {

    func getParatemerName() throws -> String {
        if let defaultParam = config.language.getDefaultParameterType(by: model) {
            return defaultParam
        }
        guard let customEnum = payload.customEnums.first(where: { $0.name == model.stringValue() }) else {
            throw ParameterTypeRawMapperError.unknownType(model.stringValue())
        }
        // TODO: переделать под тип именования (snack/camel case)
        return customEnum.name
    }

}
