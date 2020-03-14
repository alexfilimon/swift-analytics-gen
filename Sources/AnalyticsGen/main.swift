import PathKit
import Rainbow
import Foundation
import ArgumentParser
import Basic
import SPMUtility
import Core

// TODO: just for debugging through xcode
FileManager.default.changeCurrentDirectoryPath("/Users/alexfilimon/SPM/AnalyticsGen/")

struct Generate: ParsableCommand {

    // MARK: - Static Propeties

    static var configuration = CommandConfiguration(abstract: "Generating analytics layer")

    // MARK: - Options

    @Option(name: .long, default: Path("config.yaml"), help: "Path to file with config")
    var configFilePath: Path

    // MARK: - Methods

    func run() throws {

        do {
            // Generate config
            let config = try YamlConfigParser(configFilePath: configFilePath).parse()
            try ConfigValidator(config: config).validate()

            // Get customEnumsManager
            let customEnumsService = try SpreadsheetCustomEnumsService(creadentialFilePath: config.baseConig.credentialsFilePath,
                                                                       spreadsheetConfig: config.customEnumModuleConfig?.spreadsheetConfig)
            let customEnumsManager = try CustomEnumsManager(moduleConfig: config.customEnumModuleConfig,
                                                            baseConfig: config.baseConig,
                                                            customEnumsService: customEnumsService)
            try customEnumsManager.prepareForUse()

            // Get Parameter Mapper
            let parameterMapper = ParameterMapper(customEnumNameGettable: customEnumsManager,
                                                  language: config.baseConig.language)

            // Bring all context generators in one place
            var moduleContextGenerators: [ModuleContextGenerator] = [customEnumsManager]

            // Events module context gen
            if let eventConfing = config.eventsModuleConfig {
                let eventsService = try SpreadsheetEventsService(creadentialFilePath: config.baseConig.credentialsFilePath,
                                                                 spreadsheetConfig: eventConfing.spreadsheetConfig)
                let eventsModuleContextGenerator = EventsModuleContextGenerator(service: eventsService,
                                                                                baseConfig: config.baseConig,
                                                                                moduleConfig: eventConfing,
                                                                                parameterMapper: parameterMapper)
                moduleContextGenerators.append(eventsModuleContextGenerator)
            }

            // Generate all file contexts
            let contexts = try moduleContextGenerators.flatMap { try $0.generate() }
            let progress = Progress(allItems: contexts.count)
            try contexts.forEach {
                try FileGenerator(context: $0).generate()
                progress.next()
            }
        } catch {
            print("ERROR".red.bold)
            let errorDescription = ((error as? LocalizedError)?.errorDescription) ?? "UNKNOWN error"
            print(errorDescription.red)
            throw ExitCode.failure
        }
    }

}
Generate.main()
