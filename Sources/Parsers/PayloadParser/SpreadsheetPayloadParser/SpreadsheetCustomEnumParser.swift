//
//  SpreadsheetCustomEnumParser.swift
//  
//
//  Created by Alexander Filimonov on 01/03/2020.
//

import Foundation
import GoogleService
import Core
import Models

final class SpreadsheetCustomEnumParser {

    // MARK: - Private Properties

    private let spreadsheet: SpreadSheetEntry

    // MARK: - Initialization

    init(spreadsheet: SpreadSheetEntry) {
        self.spreadsheet = spreadsheet
    }

    // MARK: - Public Methods

    func getCustomEnums() -> [CustomEnum] {
        var customEnums: [CustomEnum] = []

        var customEnum: CustomEnum?
        var variant: CustomEnumVariant?
        var parameter: Parameter?

        for row in spreadsheet.values {
            let currentCustomEnumName = row[safe: 0] ?? ""
            let currentCustomEnumDescription = row[safe: 1]
            let currentVariantName = row[safe: 2] ?? ""
            let currentVariantDescription = row[safe: 3]
            let currentParameterName = row[safe: 4] ?? ""
            let currentParameterType = row[safe: 5] ?? ""
            let currentParameterDescription = row[safe: 6]

            if !currentCustomEnumName.isEmpty {
                if let parameterUnwrapped = parameter, let variantUnwrapped = variant {
                    variant = .init(name: variantUnwrapped.name,
                                    description: variantUnwrapped.description,
                                    parameters: variantUnwrapped.parameters + [parameterUnwrapped])
                    parameter = nil
                }
                if let variantUnwrapped = variant, let customEnumUnwrapped = customEnum {
                    customEnum = .init(name: customEnumUnwrapped.name,
                                       description: customEnumUnwrapped.description,
                                       variants: customEnumUnwrapped.variants + [variantUnwrapped])
                    variant = nil
                }
                if let customEnumUnwrapped = customEnum {
                    customEnums.append(customEnumUnwrapped)
                    customEnum = nil
                }
                customEnum = .init(name: currentCustomEnumName,
                                   description: currentCustomEnumDescription,
                                   variants: [])
            }

            if !currentVariantName.isEmpty {
                if let parameterUnwrapped = parameter, let variantUnwrapped = variant {
                    variant = .init(name: variantUnwrapped.name,
                                    description: variantUnwrapped.description,
                                    parameters: variantUnwrapped.parameters + [parameterUnwrapped])
                    parameter = nil
                }
                if let variantUnwrapped = variant, let customEnumUnwrapped = customEnum {
                    customEnum = .init(name: customEnumUnwrapped.name,
                                       description: customEnumUnwrapped.description,
                                       variants: customEnumUnwrapped.variants + [variantUnwrapped])
                    variant = nil
                }
                variant = .init(name: currentVariantName,
                                description: currentVariantDescription,
                                parameters: [])
            }

            if !currentParameterName.isEmpty {
                if let parameterUnwrapped = parameter, let variantUnwrapped = variant {
                    variant = .init(name: variantUnwrapped.name,
                                    description: variantUnwrapped.description,
                                    parameters: variantUnwrapped.parameters + [parameterUnwrapped])
                    parameter = nil
                }
                parameter = .init(name: currentParameterName,
                                  description: currentParameterDescription,
                                  type: .init(raw: currentParameterType))
            }

        }

        if let parameterUnwrapped = parameter, let variantUnwrapped = variant {
            variant = .init(name: variantUnwrapped.name,
                            description: variantUnwrapped.description,
                            parameters: variantUnwrapped.parameters + [parameterUnwrapped])
            parameter = nil
        }
        if let variantUnwrapped = variant, let customEnumUnwrapped = customEnum {
            customEnum = .init(name: customEnumUnwrapped.name,
                               description: customEnumUnwrapped.description,
                               variants: customEnumUnwrapped.variants + [variantUnwrapped])
            variant = nil
        }
        if let customEnumUnwrapped = customEnum {
            customEnums.append(customEnumUnwrapped)
            customEnum = nil
        }

        return customEnums
    }

}
