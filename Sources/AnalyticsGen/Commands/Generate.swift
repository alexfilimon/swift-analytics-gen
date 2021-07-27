//
//  Generate.swift
//  
//
//  Created by Alexander Filimonov on 26/05/2020.
//

import PathKit
import Foundation
import ArgumentParser
//import Basic
//import SPMUtility
import TSCBasic
import TSCUtility
import Core

struct Generate: Decodable, ParsableCommand {

    // MARK: - Constants

    // MARK: - Static Propeties

    static var configuration = CommandConfiguration(abstract: "Generating analytics layer")

    // MARK: - Options

    // TODO: remove default
//    @Option(name: .long, initial: "config.yaml", parsingStrategy: .next, help: "Path to file with config")
    @Option(wrappedValue: "config.yaml", name: .long, parsing: .next, completion: nil, help: "Path to file with config")
    var configFilePath: Path

//    @Option(name: .long, initial: false, parsingStrategy: .next, help: "Need loging process")
    @Option(wrappedValue: false, name: .long, parsing: .next, completion: nil, help: "Need loging process")
    var shouldLog: Bool

    // MARK: - Methods

    func run() throws {
        let tc = TerminalController(stream: stdoutStream)
        let stepsPrinter = StepsPrinter(tc: tc, color: .green, stepsCount: 6)

        do {
            printDataAboutScript(into: tc)

            stepsPrinter.add("Starting script")

            // Config
            stepsPrinter.add("Parsing config file from: \(configFilePath.absolute().string)")
            let config = try YamlConfigParser(configFilePath: configFilePath).parse()
            stepsPrinter.add("Validating config file")
            try ConfigValidator(config: config).validate()

            // Custom enums
            stepsPrinter.add("Preparing custom enums")
            let (parameterMapper, moduleContextGenerator) = try prepareCustomEnumsManager(
                baseConfig: config.baseConfig,
                moduleConfig: config.customEnumModuleConfig
            )

            // User Properties
            stepsPrinter.add("Preparing user properties")
            let userPropertiesModuleContextGenerator = try prepareUserPropertiesContext(
                parameterMapper: parameterMapper,
                baseConfig: config.baseConfig,
                moduleConfig: config.userPropertiesModuleConfig
            )

            // Events
            stepsPrinter.add("Preparing events")
            let eventsModuleConfigGenerators = try generateEventsContexts(
                parameterMapper: parameterMapper,
                baseConfig: config.baseConfig,
                moduleConfig: config.eventsModuleConfig,
                categoriesExtensionTemplatePath: config.categoriesExtensionTemplatePath,
                categoriesExtensionOutputPath: config.categoriesExtensionOutputPath
            )

            // Generate all file contexts
            stepsPrinter.add("Generating files")
            try generateAllModuleContexts(
                [
                    [moduleContextGenerator],
                    eventsModuleConfigGenerators,
                    [userPropertiesModuleContextGenerator]
                ].flatMap({ (value: [ModuleContextGenerator?]) -> [ModuleContextGenerator?] in
                    return value
                }).compactMap { $0 },
                tc: tc
            )
        } catch {
            printErrorHeader(into: tc)
            printErrorInfo(into: tc, error: error)
            throw ExitCode.failure
        }
    }

}

// MARK: - Private Methods

private extension Generate {

    func printDataAboutScript(into tc: TerminalController?) {
        OneColumnTable(tc: tc, width: 60, color: .white)
            .add([
                OneColumnTable.Row(
                    string: "Analytics Generator",
                    color: .green,
                    isBold: true,
                    alignment: .center
                ),
                OneColumnTable.Row(
                    strings: [
                        "Version: \(LibConstants.version)",
                        "Author: Alexander Filimonov (alexfilimon)"
                    ],
                    color: .yellow,
                    alignment: .left
                ),
                OneColumnTable.Row(
                    string: "Surf 2020",
                    color: .red,
                    isBold: true,
                    alignment: .center
                )
            ])
            .render()
    }

    func printErrorHeader(into tc: TerminalController?) {
        OneColumnTable(tc: tc, width: 60, color: .red)
            .add(OneColumnTable.Row(string: "Error was occured", color: .red, isBold: true, alignment: .center))
            .render()
    }

    func printErrorInfo(into tc: TerminalController?, error: Error) {
        let localizedError = error as? LocalizedError
        let errorString = localizedError?.errorDescription ?? error.localizedDescription
        tc?.write(errorString, inColor: .red)
        tc?.endLine()
    }

    /// Parse data source with custom enums and returns
    /// - manager for working with parameters
    /// - module context generator for generating files with enums
    func prepareCustomEnumsManager(baseConfig: BaseConfig,
                                   moduleConfig: ModuleConfig?) throws -> (ParameterMapper, ModuleContextGenerator?) {
        // Get customEnumsManager
        let customEnumsService = try SpreadsheetCustomEnumsService(creadentialFilePath: baseConfig.credentialsFilePath,
                                                                   spreadsheetConfig: moduleConfig?.spreadsheetConfig,
                                                                   shouldLog: shouldLog)
        let customEnumsManager: CustomEnumsManager?
        if let moduleConfig = moduleConfig {
            customEnumsManager = try CustomEnumsManager(moduleConfig: moduleConfig,
                                                        baseConfig: baseConfig,
                                                        customEnumsService: customEnumsService)
            try customEnumsManager?.prepareForUse()
        } else {
            customEnumsManager = nil
        }

        // Get Parameter Mapper
        let parameterMapper = ParameterMapper(customEnumNameGettable: customEnumsManager,
                                              language: baseConfig.language)

        return (parameterMapper, customEnumsManager)
    }

    func prepareUserPropertiesContext(parameterMapper: ParameterMapper,
                                      baseConfig: BaseConfig,
                                      moduleConfig: ModuleConfig?) throws -> ModuleContextGenerator? {
        guard let moduleConfigUnwrapped = moduleConfig else {
            return nil
        }
        let service = try SpreadsheetUserPropertiesService(
            creadentialFilePath: baseConfig.credentialsFilePath,
            spreadsheetConfig: moduleConfigUnwrapped.spreadsheetConfig,
            shouldLog: shouldLog
        )
        let moduleContextGenerator = UserPropertiesModuleContextGenerator(
            service: service,
            baseConfig: baseConfig,
            moduleConfig: moduleConfigUnwrapped,
            parameterMapper: parameterMapper
        )
        return moduleContextGenerator
    }

    func generateEventsContexts(parameterMapper: ParameterMapper,
                                baseConfig: BaseConfig,
                                moduleConfig: ModuleConfig?,
                                categoriesExtensionTemplatePath: Path?,
                                categoriesExtensionOutputPath: Path?) throws -> [ModuleContextGenerator] {
        guard let eventConfing = moduleConfig else {
            return []
        }

        var allModuleContextGenerators: [ModuleContextGenerator] = []

        // events
        let eventsService = try SpreadsheetEventsService(creadentialFilePath: baseConfig.credentialsFilePath,
                                                         spreadsheetConfig: eventConfing.spreadsheetConfig,
                                                         shouldLog: shouldLog)
        let eventsModuleContextGenerator = EventsModuleContextGenerator(service: eventsService,
                                                                        baseConfig: baseConfig,
                                                                        moduleConfig: eventConfing,
                                                                        parameterMapper: parameterMapper)
        allModuleContextGenerators.append(eventsModuleContextGenerator)

        // category extension for events
        if
            let categoryExtTemplatePath = categoriesExtensionTemplatePath,
            let categoryExtOutput = categoriesExtensionOutputPath
        {
            let module = CategoriesExtensionModuleContextGenerator(
                categories: try eventsModuleContextGenerator.getEvents(),
                categoriesExtensionTemplatePath: categoryExtTemplatePath,
                categoriesExtensionOutputPath: categoryExtOutput,
                language: baseConfig.language,
                namePostfix: eventConfing.namingPostfix
            )
            allModuleContextGenerators.append(module)
        }

        return allModuleContextGenerators
    }

    func generateAllModuleContexts(_ moduleContextsGenerators: [ModuleContextGenerator],
                                   tc: TerminalController?) throws {
        let contexts = try moduleContextsGenerators.flatMap { try $0.generate() }
        try contexts.forEach {
            tc?.write("Generating file: \($0.filePath)", inColor: .gray)
            tc?.endLine()
            try FileGenerator(context: $0).generate()
        }
    }

}
