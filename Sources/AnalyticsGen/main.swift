import PathKit
import Rainbow
import GoogleTokenProvider
import GoogleService
import Foundation

do {
    let provider = try GoogleTokenProvider(scopes: ["https://www.googleapis.com/auth/drive"], credentialFilePath: Path("/Users/alexfilimon/SPM/AnalyticsGen/google.json"))
    let googleSpreadsheetService = GoogleSpreadsheetService(tokenProvider: provider)
    let spreadsheet = try googleSpreadsheetService.getGoogleSheetData(spreadSheetId: "1_w6NmTK4Ju3i2PacB4-D7WCvpWduikBYnvw2PSi2c9c",
                                                                      pageId: "Version_1.0",
                                                                      range: "A2:F")
    print("Success getted spreadheet".green)
} catch {
    print("ERROR".red.bold)
    let errorDescription = ((error as? LocalizedError)?.errorDescription) ?? "UNKNOWN error"
    print(errorDescription.red)
}
