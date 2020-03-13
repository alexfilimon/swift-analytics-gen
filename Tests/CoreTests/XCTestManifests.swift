import XCTest

extension SpreadsheetPayloadParserTest {
    static let __allTests = [
        ("testEventsSpreadsheetPayloadParsing", testEventsSpreadsheetPayloadParsing),
        ("testCustomEnumsSpreadsheetPayloadParsing", testCustomEnumsSpreadsheetPayloadParsing)
    ]
}

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SpreadsheetPayloadParserTest.__allTests),
    ]
}
#endif
