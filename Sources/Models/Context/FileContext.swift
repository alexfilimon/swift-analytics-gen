//
//  FileContext.swift
//  
//
//  Created by Alexander Filimonov on 06/03/2020.
//

import Foundation
import PathKit

public struct FileContext {

    // MARK: - Public Properties

    public let filePath: Path
    public let context: [String: Any]

    // MARK: - Initialization

    public init(filePath: Path,
                context: [String: Any]) {
        self.filePath = filePath
        self.context = context
    }

}
