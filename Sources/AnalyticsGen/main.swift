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
            let customEnumsService = try SpreadsheetCustomEnumsService(creadentialFilePath: config.baseConig.credentialsFilePath,
                                                                       spreadsheetConfig: config.customEnumModuleConfig?.spreadsheetConfig)
            let customEnumsManager = try CustomEnumsManager(moduleConfig: config.customEnumModuleConfig,
                                                            baseConfig: config.baseConig,
                                                            customEnumsService: customEnumsService)
            try customEnumsManager.prepareForUse()

            // Get Parameter Mapper
            let parameterMapper = ParameterMapper(customEnumNameGettable: customEnumsManager,
                                                  language: config.baseConig.language)

            var moduleContextGenerators: [ModuleContextGenerator] = [customEnumsManager]

            // Events module context gen
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

