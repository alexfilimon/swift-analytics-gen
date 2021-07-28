//
//  KotlinLanguageTests.swift
//  
//
//  Created by Alexander Filimonov on 10/02/2021.
//

import XCTest
import Spectre
@testable import Core

final class KotlinLanguageTests: XCTestCase {

    let language: Language = KotlinLanguage()

    func testLanguageProtocol() {
        it("language extension") {
            try expect(self.self.language.fileExtension) == "kt"
        }

        it("raw name") {
            try expect(self.self.language.rawName) == "kotlin"
        }

        it("default parameter's names") {
            try expect(self.language.getDefaultParameterTypeName(by: .date)) == "LocalDateTime"
            try expect(self.language.getDefaultParameterTypeName(by: .bool)) == "Boolean"
            try expect(self.language.getDefaultParameterTypeName(by: .double)) == "Double"
            try expect(self.language.getDefaultParameterTypeName(by: .int)) == "Int"
            try expect(self.language.getDefaultParameterTypeName(by: .string)) == "String"
            try expect(self.language.getDefaultParameterTypeName(by: .customEnum(name: "custom_enum"))) == Optional<String>.none
        }

        it("final name") {
            try expect(self.language.getFinalName(name: "hello_world", needCapitalizeFirst: true)) == "HelloWorld"
            try expect(self.language.getFinalName(name: "hello_world", needCapitalizeFirst: false)) == "helloWorld"
        }

        it("name for custom enum") {
            try expect(self.language.getCustomEnumName(name: "hello_world")) == "HELLO_WORLD"
        }

        it("file name") {
            try expect(self.language.getFileName(name: "hello_world")) == "HelloWorld.kt"
        }
    }

}
