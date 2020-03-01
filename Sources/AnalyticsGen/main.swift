import PathKit
import Rainbow
import Parsers
import GoogleTokenProvider
import GoogleService
import Foundation
import Core

let baseFolder = Path("/Users/alexfilimon/SPM/AnalyticsGen/")
let nameConfig = NamingConfig(categoryNamePostfix: "Category",
                              userPropertyPostfix: "UserProperty")
let pathConfig = PathConfig(outputFolderPath: baseFolder + .init("output/other/folder"),
                            templateFilePath: baseFolder + .init("template.stencil"),
                            credentialsFilePath: baseFolder + .init("google.json"))
let config = Config(namingConfig: nameConfig,
                    pathConfig: pathConfig,
                    language: .swift,
                    spreadsheedCustomEnumsConfig: .init(id: "1_w6NmTK4Ju3i2PacB4-D7WCvpWduikBYnvw2PSi2c9c",
                                                        pageName: "Types",
                                                        range: "A2:G100"),
                    spreadsheetUserPropertiesConfig: .init(id: "", pageName: "", range: ""),
                    spreadsheetEventsConfig: .init(id: "1_w6NmTK4Ju3i2PacB4-D7WCvpWduikBYnvw2PSi2c9c",
                                                   pageName: "Version_1.0",
                                                   range: "A2:F100"))

do {
    let payload = try SpreadsheetPayloadParser(config: config).getPayload()
    print()
} catch {
    print("ERROR".red.bold)
    let errorDescription = ((error as? LocalizedError)?.errorDescription) ?? "UNKNOWN error"
    print(errorDescription.red)
}
