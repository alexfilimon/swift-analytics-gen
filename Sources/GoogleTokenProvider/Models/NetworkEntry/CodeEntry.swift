//
//  CodeEntry.swift
//  
//
//  Created by Alexander Filimonov on 01/03/2020.
//

struct CodeEntry: Decodable {

    // MARK: - Properties

    var code: String?
    var error: String?

    // MARK: - Initializaion

    init(queryParams: [(String, String)]) {
        for param in queryParams {
            switch param.0 {
            case "code":
                self.code = param.1
            case "error":
                self.error = param.1
            default:
                break
            }
        }
    }

}
