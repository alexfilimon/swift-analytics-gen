//
//  ParameterMapper.swift
//  
//
//  Created by Alexander Filimonov on 13/03/2020.
//

/// Class for tranfering parameters to raw representation
/// (it knows custom enums)
public final class ParameterMapper {

    // MARK: - Private Properties

    private let customEnumNameGettable: CustomEnumNameGettable
    private let language: Language

    // MARK: - Initialization

    /// Initializer for class
    /// - Parameters:
    ///   - customEnumNameGettable: entity for getting names of customEnums
    ///   - language: language to use
    public init(customEnumNameGettable: CustomEnumNameGettable,
                language: Language) {
        self.customEnumNameGettable = customEnumNameGettable
        self.language = language
    }

    // MARK: - Public Methods

    /// Mapping method
    /// - Parameter parameter: parameter that need to be translating
    public func map(parameter: Parameter) throws -> [String: Any] {
        let (isEnum, typeName) = try getParatemerName(parameter: parameter)
        return [
            "name": parameter.name.snackToCamel(capitalizingFirst: false),
            "description": parameter.description as Any,
            "is_enum": isEnum,
            "type": typeName
        ]
    }

}

// MARK: - Private Methods

private extension ParameterMapper {

    func getParatemerName(parameter: Parameter) throws -> (isEnum: Bool, typeName: String) {
        if let defaultParam = language.getDefaultParameterTypeName(by: parameter.type) {
            return (isEnum: false, typeName: defaultParam)
        }
        return (isEnum: true, typeName: try customEnumNameGettable.getFinalName(forName: parameter.type.stringValue()))
    }

}
