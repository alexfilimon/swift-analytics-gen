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
        let (isEnum, typeName) = try getParatemerName()
        return [
            "name": model.name.snackToCamel(capitalizingFirst: false),
            "description": model.description as Any,
            "is_enum": isEnum,
            "type": typeName
        ]
    }

}

// MARK: - Private Methods

private extension ParameterRawMapper {

    func getParatemerName() throws -> (isEnum: Bool, typeName: String) {
        if let defaultParam = config.language.getDefaultParameterType(by: model.type) {
            return (isEnum: false, typeName: defaultParam)
        }
        guard let customEnum = payload.customEnums.first(where: { $0.name == model.type.stringValue() }) else {
            throw ParameterRawMapperError.unknownType(model.type.stringValue())
        }
        let customEnumName = CustomEnumNameManager(customEnum: customEnum, customEnumsConfig: config.customEnumModuleConfig).getName()
        return (isEnum: true, typeName: customEnumName)
    }

}
