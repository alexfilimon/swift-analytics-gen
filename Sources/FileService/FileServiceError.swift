//
//  FileServiceError.swift
//  
//
//  Created by Alexander Filimonov on 29/02/2020.
//

import Foundation

public enum FileServiceError: Error {
    case fileDoesentExist(filePath: String)

    // MARK: - LocalizedError

    public var localizedDescription: String {
        switch self {
        case .fileDoesentExist(let filePath):
            return "File \(filePath) doesent exists"
        }
    }

    public var errorDescription: String? {
        return localizedDescription
    }

}
