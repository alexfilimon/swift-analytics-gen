//
//  SpreadsheetCustomEnumParser.swift
//  
//
//  Created by Alexander Filimonov on 01/03/2020.
//

import Foundation
import Service

final class SpreadsheetCustomEnumParser {

    // MARK: - Private Properties

    private let spreadsheet: Spreadsheet

    // MARK: - Initialization

    init(spreadsheet: Spreadsheet) {
        self.spreadsheet = spreadsheet
    }

    // MARK: - Public Methods

    func getCustomEnums() -> [CustomEnum] {
        var customEnums: [CustomEnum] = []

        var customEnum: CustomEnum?
        var variant: CustomEnumVariant?

        for row in spreadsheet.values {
            let currentCustomEnumName = row[safe: 0] ?? ""
            let currentCustomEnumDescription = row[safe: 1]
            let currentVariantName = row[safe: 2] ?? ""
            let currentVariantDescription = row[safe: 3]

            if !currentCustomEnumName.isEmpty {
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
                if let variantUnwrapped = variant, let customEnumUnwrapped = customEnum {
                    customEnum = .init(name: customEnumUnwrapped.name,
                                       description: customEnumUnwrapped.description,
                                       variants: customEnumUnwrapped.variants + [variantUnwrapped])
                    variant = nil
                }
                variant = .init(name: currentVariantName,
                                description: currentVariantDescription)
            }

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
