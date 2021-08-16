//
//  CustomEnumsManagerTests.swift
//  
//
//  Created by Alexander Filimonov on 10/02/2021.
//

import XCTest
import Spectre
import PathKit
@testable import Core

final class CustomEnumsManagerTests: XCTestCase {

    func testNameGettableForSwift() {
        it("name getted properly") {
            let moduleConfig = ModuleConfig(
                namingPostfix: "custom_enum",
                templateFilePath: "",
                outputFolderPath: "",
                spreadsheetConfig: SpreadsheetConfig(
                    id: "",
                    pageName: "",
                    range: ""
                )
            )
            let language = SwiftLanguage()
            let baseConfig = BaseConfig(
                credentialsFilePath: "",
                language: language
            )
            let customEnumService: CustomEnumsAbstractService = MockCustomEnumsService()
            let manager = try CustomEnumsManager(
                moduleConfig: moduleConfig,
                baseConfig: baseConfig,
                customEnumsService: customEnumService
            )
            try manager.prepareForUse()

            let testableEnumName_1 = "payment_state"
            let expectedEnumName_1 = language.getCustomEnumName(name: "payment_state_\(moduleConfig.namingPostfix)")
            let result_1 = try manager.getFinalName(forName: testableEnumName_1)
            try expect(result_1) == expectedEnumName_1

            let testableEnumName_2 = "server_status"
            let expectedEnumName_2 = language.getCustomEnumName(name: "server_status_\(moduleConfig.namingPostfix)")
            let result_2 = try manager.getFinalName(forName: testableEnumName_2)
            try expect(result_2) == expectedEnumName_2
        }
    }

    func testNameGettableForKotlin() {
        it("name getted properly") {
            let moduleConfig = ModuleConfig(
                namingPostfix: "custom_enum",
                templateFilePath: "",
                outputFolderPath: "",
                spreadsheetConfig: SpreadsheetConfig(
                    id: "",
                    pageName: "",
                    range: ""
                )
            )
            let language = KotlinLanguage()
            let baseConfig = BaseConfig(
                credentialsFilePath: "",
                language: language
            )
            let customEnumService: CustomEnumsAbstractService = MockCustomEnumsService()
            let manager = try CustomEnumsManager(
                moduleConfig: moduleConfig,
                baseConfig: baseConfig,
                customEnumsService: customEnumService
            )
            try manager.prepareForUse()

            let testableEnumName_1 = "payment_state"
            let expectedEnumName_1 = language.getCustomEnumName(name: "payment_state_\(moduleConfig.namingPostfix)")
            let result_1 = try manager.getFinalName(forName: testableEnumName_1)
            try expect(result_1) == expectedEnumName_1

            let testableEnumName_2 = "server_status"
            let expectedEnumName_2 = language.getCustomEnumName(name: "server_status_\(moduleConfig.namingPostfix)")
            let result_2 = try manager.getFinalName(forName: testableEnumName_2)
            try expect(result_2) == expectedEnumName_2
        }
    }

    func testModuleContextGeneratorForKotlin() {
        it("name getted properly") {
            let moduleConfig = ModuleConfig(
                namingPostfix: "custom_enum",
                templateFilePath: "template",
                outputFolderPath: "output",
                spreadsheetConfig: SpreadsheetConfig(
                    id: "",
                    pageName: "",
                    range: ""
                )
            )
            let language = KotlinLanguage()
            let baseConfig = BaseConfig(
                credentialsFilePath: "",
                language: language
            )
            let customEnumService = MockCustomEnumsService()
            let manager = try CustomEnumsManager(
                moduleConfig: moduleConfig,
                baseConfig: baseConfig,
                customEnumsService: customEnumService
            )
            try manager.prepareForUse()
            let _ = try manager.getFinalName(forName: "payment_state")
            let _ = try manager.getFinalName(forName: "server_status")

            let fileContexts = try manager.generate()
            let expectedFileContexts = customEnumService.getFileContextsForKotlin(postfix: moduleConfig.namingPostfix)

            try expect(fileContexts) == expectedFileContexts
        }
    }

    func testModuleContextGeneratorForSwift() {
        it("name getted properly") {
            let moduleConfig = ModuleConfig(
                namingPostfix: "custom_enum",
                templateFilePath: "template",
                outputFolderPath: "output",
                spreadsheetConfig: SpreadsheetConfig(
                    id: "",
                    pageName: "",
                    range: ""
                )
            )
            let language = SwiftLanguage()
            let baseConfig = BaseConfig(
                credentialsFilePath: "",
                language: language
            )
            let customEnumService = MockCustomEnumsService()
            let manager = try CustomEnumsManager(
                moduleConfig: moduleConfig,
                baseConfig: baseConfig,
                customEnumsService: customEnumService
            )
            try manager.prepareForUse()
            let _ = try manager.getFinalName(forName: "payment_state")
            let _ = try manager.getFinalName(forName: "server_status")

            let fileContexts = try manager.generate()
            let expected = customEnumService.getFileContextsForSwift(postfix: moduleConfig.namingPostfix)

            try expect(fileContexts) == expected
        }
    }

}

private final class MockCustomEnumsService: CustomEnumsAbstractService {

    func getCustomEnums() throws -> [CustomEnum] {
        return [
            .init(name: "payment_state", description: "State of payment", variants: [
                .init(name: "recieved", description: "Payment recieved"),
                .init(name: "failed", description: "Payment failed")
            ]),
            .init(name: "server_status", description: "Status of server's response", variants: [
                .init(name: "good_status", description: "Good response"),
                .init(name: "bad_status", description: "Bad response")
            ])
        ]
    }

    func getFileContextsForSwift(postfix: String) -> [FileContext] {
        let actualPostfix = postfix.snackToCamel(capitalizingFirst: true)
        return [
            .init(filePath: Path("output/PaymentState\(actualPostfix).swift"), templateFilePath: "template", context: [
                "name": "PaymentState\(actualPostfix)",
                "description": "State of payment",
                "variants": [
                    [
                        "name": "recieved",
                        "description": "Payment recieved",
                        "raw_value": "recieved"
                    ],
                    [
                        "name": "failed",
                        "description": "Payment failed",
                        "raw_value": "failed"
                    ]
                ]
            ]),
            .init(filePath: Path("output/ServerStatus\(actualPostfix).swift"), templateFilePath: "template", context:[
                "name": "ServerStatus\(actualPostfix)",
                "description": "Status of server's response",
                "variants": [
                    [
                        "name": "goodStatus",
                        "description": "Good response",
                        "raw_value": "good_status"
                    ],
                    [
                        "name": "badStatus",
                        "description": "Bad response",
                        "raw_value": "bad_status"
                    ]
                ]
            ])
        ]
    }

    func getFileContextsForKotlin(postfix: String) -> [FileContext] {
        let snackPostfix = postfix.snackToCamel(capitalizingFirst: true)
        let actualPostfix = postfix.uppercased()
        return [
            .init(filePath: Path("output/PaymentState\(snackPostfix).kt"), templateFilePath: "template", context: [
                "name": "PAYMENT_STATE_\(actualPostfix)",
                "description": "State of payment",
                "variants": [
                    [
                        "name": "recieved",
                        "description": "Payment recieved",
                        "raw_value": "recieved"
                    ],
                    [
                        "name": "failed",
                        "description": "Payment failed",
                        "raw_value": "failed"
                    ]
                ]
            ]),
            .init(filePath: Path("output/ServerStatus\(snackPostfix).kt"), templateFilePath: "template", context:[
                "name": "SERVER_STATUS_\(actualPostfix)",
                "description": "Status of server's response",
                "variants": [
                    [
                        "name": "goodStatus",
                        "description": "Good response",
                        "raw_value": "good_status"
                    ],
                    [
                        "name": "badStatus",
                        "description": "Bad response",
                        "raw_value": "bad_status"
                    ]
                ]
            ])
        ]
    }

}
