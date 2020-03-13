import PathKit
import Rainbow
import Parsers
import GoogleTokenProvider
import GoogleService
import Foundation
import Core
import Models
import ArgumentParser
import Basic
import SPMUtility

extension Path: ExpressibleByArgument {
    public init?(argument: String) {
        self.init(argument)
    }
}

struct Generate: ParsableCommand {

    static var configuration = CommandConfiguration(abstract: "Generating analytics layer")

    @Option(name: .long, default: Path("config.yaml"), help: "Path to file with config")
    var configFilePath: Path

    mutating func validate() throws {
        guard configFilePath.isFile else {
            print("File '\(configFilePath.lastComponent)' doesent exists at path '\(configFilePath.absolute())'".red)
            throw ExitCode.validationFailure
        }
    }

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
//        FileManager.default.changeCurrentDirectoryPath("/Users/alexfilimon/SPM/AnalyticsGen/")



        do {


            let config = try YamlConfigParser(configFilePath: configFilePath).parse()
            let payload = try SpreadsheetPayloadParser(config: config).getPayload()

            // generating events
            let eventsContextGenerator = EventsCategoriesContextGenerator(config: config, payload: payload)
            let eventsContexts = try eventsContextGenerator.generate()

            // generating custom enums
            let customEnumsContextGenerator = CustomEnumsContextGenerator(config: config, payload: payload)
            let customEnumsContexts = try customEnumsContextGenerator.generate()

            let progress = Progress(allItems: eventsContexts.count + customEnumsContexts.count)
            try eventsContexts.forEach {
                try FileGenerator(context: $0, config: config.eventsModuleConfig).generate()
                progress.next()
            }
            try customEnumsContexts.forEach {
                try FileGenerator(context: $0, config: config.customEnumModuleConfig).generate()
                progress.next()
            }

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

