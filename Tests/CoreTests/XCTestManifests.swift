import XCTest

extension SpreadsheetPayloadParserTest {
    static let __allTests = [
        ("testEventsSpreadsheetPayloadParsing", testEventsSpreadsheetPayloadParsing),
        ("testCustomEnumsSpreadsheetPayloadParsing", testCustomEnumsSpreadsheetPayloadParsing)
    ]
}

extension SwiftLanguageTests {
    static let __allTests = [
        ("testLanguageProtocol", testLanguageProtocol)
    ]
}

extension KotlinLanguageTests {
    static let __allTests = [
        ("testLanguageProtocol", testLanguageProtocol)
    ]
}

extension CustomEnumsManagerTests {
    static let __allTests = [
        ("testNameGettableForSwift", testNameGettableForSwift),
        ("testNameGettableForKotlin", testNameGettableForKotlin),
        ("testModuleContextGeneratorForKotlin", testModuleContextGeneratorForKotlin),
        ("testModuleContextGeneratorForSwift", testModuleContextGeneratorForSwift)
    ]

}

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SpreadsheetPayloadParserTest.__allTests),
        testCase(SwiftLanguageTests.__allTests),
        testCase(KotlinLanguageTests.__allTests),
        testCase(CustomEnumsManagerTests.__allTests)
    ]
}
#endif
