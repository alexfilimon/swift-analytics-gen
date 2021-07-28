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

    private let customEnumNameGettable: CustomEnumNameGettable?
    private let language: Language

    // MARK: - Initialization

    /// Initializer for class
    /// - Parameters:
    ///   - customEnumNameGettable: entity for getting names of customEnums
    ///   - language: language to use
    public init(customEnumNameGettable: CustomEnumNameGettable?,
                language: Language) {
        self.customEnumNameGettable = customEnumNameGettable
        self.language = language
    }

    // MARK: - Public Methods

    /// Mapping method
    /// - Parameter parameter: parameter that need to be translating
    public func map(parameter: Parameter) throws -> [String: Any] {
        let (isEnum, typeName) = try getParatemerName(parameterType: parameter.type)
        return [
            "name": language.getFinalName(name: parameter.name, needCapitalizeFirst: false),
            "raw_name": parameter.name,
            "description": parameter.description as Any,
            "is_enum": isEnum,
            "type": typeName
        ]
    }

    /// Mapping method
    /// - Parameter parameterType: type of parameter that need to be translated
    public func map(parameterType: ParameterType) throws -> [String: Any] {
        let (isEnum, typeName) = try getParatemerName(parameterType: parameterType)
        return [
            "is_enum": isEnum,
            "type": typeName,
            "raw_type": parameterType.stringValue()
        ]
    }

}

// MARK: - Private Methods

private extension ParameterMapper {

    func getParatemerName(parameterType: ParameterType) throws -> (isEnum: Bool, typeName: String) {
        // try to get default parameter's name
        if let defaultParam = language.getDefaultParameterTypeName(by: parameterType) {
            return (isEnum: false, typeName: defaultParam)
        }

        // try to get custom enum's name
        let parameterStringValue = parameterType.stringValue()
        guard let customEnumNameGettable = customEnumNameGettable else {
            throw ParameterMapperError.thereIsNoEnumGettable(forEnum: parameterStringValue)
        }
        return (
            isEnum: true,
            typeName: try customEnumNameGettable.getFinalName(
                forName: parameterStringValue
            )
        )
    }

}
