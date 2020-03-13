import PathKit
import Rainbow
import Foundation
import ArgumentParser
import Basic
import SPMUtility
import Core

extension Path: ExpressibleByArgument {
    public init?(argument: String) {
        self.init(argument)
    }
}

FileManager.default.changeCurrentDirectoryPath("/Users/alexfilimon/SPM/AnalyticsGen/")

struct Generate: ParsableCommand {

    static var configuration = CommandConfiguration(abstract: "Generating analytics layer")

    @Option(name: .long, default: Path("config.yaml"), help: "Path to file with config")
    var configFilePath: Path

    func run() throws {


//        if let stdout = stdoutStream as? LocalFileOutputByteStream {
//        let colors: [TerminalController.Color] = [.red, .green, .yellow, .cyan, .white]
//
//        let tc = TerminalController(stream: stdoutStream)
//
//        for (index, letter) in "Hello, world!".enumerated() {
//            tc?.write(String(letter), inColor: colors[index % colors.count], bold: true)
//        }
//
//        tc?.endLine()
//        for i in 0...50 {
//            tc?.clearLine()
//            tc?.write("progress \(i*2)% : [")
//            for j in 0...50 {
//                if j <= i {
//                    tc?.write("-")
//                } else {
//                    tc?.write(" ")
//                }
//            }
//            tc?.write("]")
//            Thread.sleep(forTimeInterval: 0.05)
//        }
////        tc?.clearLine()
////        }

        // TODO: just for debugging
//



        do {

            // Generate config
            let config = try YamlConfigParser(configFilePath: configFilePath).parse()
            try ConfigValidator(config: config).validate()

            // Get customEnumsManager
            let customEnumsManager = try CustomEnumsManager(moduleConfig: config.customEnumModuleConfig,
                                                            baseConfig: config.baseConig)
            try customEnumsManager.prepareForUse()

            // Get Parameter Mapper
            let parameterMapper = ParameterMapper(customEnumNameGettable: customEnumsManager,
                                                  language: config.baseConig.language)

            var moduleContextGenerators: [ModuleContextGenerator] = [customEnumsManager]

            if let eventConfing = config.eventsModuleConfig {
                let eventModuleContextGenerator = BaseModuleContextGen<Spreadsheet, EventCategory, GoogleSheetModuleContextGenService, GoogleSheetEventsParser, EventContextGen>(
                    service: GoogleSheetModuleContextGenService(
                        creadentialFilePath: config.baseConig.credentialsFilePath,
                        spreadsheetRequest: eventConfing.spreadsheetConfig
                    ),
                    baseConfig: config.baseConig,
                    moduleConfig: eventConfing,
                    parameterMapper: parameterMapper
                )
                moduleContextGenerators.append(eventModuleContextGenerator)
            }

            let contexts = try moduleContextGenerators.flatMap { try $0.generate() }
            try contexts.forEach {
                try FileGenerator(context: $0).generate()
            }

//            let payload = try SpreadsheetPayloadParser(config: config).parse()
//
//            // generating events
//            let eventsContextGenerator = EventsCategoriesContextGenerator(config: config, payload: payload)
//            let eventsContexts = try eventsContextGenerator.generate()
//
//            // generating custom enums
//            let customEnumsContextGenerator = CustomEnumsContextGenerator(config: config, payload: payload)
//            let customEnumsContexts = try customEnumsContextGenerator.generate()
//
//            let progress = Progress(allItems: eventsContexts.count + customEnumsContexts.count)
//            try eventsContexts.forEach {
//                try FileGenerator(context: $0, config: config.eventsModuleConfig).generate()
//                progress.next()
//            }
//            try customEnumsContexts.forEach {
//                try FileGenerator(context: $0, config: config.customEnumModuleConfig).generate()
//                progress.next()
//            }

            print()
//            Thread.sleep(forTimeInterval: 1)
        } catch {
            print("ERROR".red.bold)
            let errorDescription = ((error as? LocalizedError)?.errorDescription) ?? "UNKNOWN error"
            print(errorDescription.red)
            throw ExitCode.failure
        }
    }

}
Generate.main()

