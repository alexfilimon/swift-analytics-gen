//
//  SpreadsheetPayloadParserTest.swift
//  
//
//  Created by Alexander Filimonov on 13/03/2020.
//

import XCTest
import Spectre
@testable import Core

final class SpreadsheetPayloadParserTest: XCTestCase {

    func testEventsSpreadsheetPayloadParsing() {
        describe("Events spreadsheet") {
            var spreadsheet: Spreadsheet!

            $0.before {
                spreadsheet = .init(
                    range: "",
                    majorDimension: "",
                    values: [
                        ["category", "category description",
                         "event_1", "",
                         "param_1_name", "string", "param_1 description"],
                        ["", "",
                         "", "",
                         "param_2_name", "int", "param_2 description"],
                        ["", "",
                         "event_2", "event_2 description",
                         "", "", ""]
                    ]
                )
            }

            $0.it("allows you to parse valid event categories") {
                let expectedEventCategories: [EventCategory] = [
                    .init(name: "category", description: "category description", events: [
                        .init(name: "event_1", description: nil, parameters: [
                            .init(name: "param_1_name", description: "param_1 description", type: .string),
                            .init(name: "param_2_name", description: "param_2 description", type: .int)
                        ]),
                        .init(name: "event_2", description: "event_2 description", parameters: [])
                    ])
                ]
                let spreadsheetParser = SpreadsheetEventsParser(spreadsheet: spreadsheet)
//                try expect(spreadsheetParser.getEvents()) == expectedEventCategories
            }
        }
    }

    func testCustomEnumsSpreadsheetPayloadParsing() {
//        describe(<#T##name: String##String#>, <#T##closure: (ContextType) -> Void##(ContextType) -> Void#>)
    }

}
