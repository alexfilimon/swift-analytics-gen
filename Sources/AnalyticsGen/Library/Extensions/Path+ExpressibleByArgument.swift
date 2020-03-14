//
//  Path+ExpressibleByArgument.swift
//  
//
//  Created by Alexander Filimonov on 14/03/2020.
//

import PathKit
import ArgumentParser

extension Path: ExpressibleByArgument {
    public init?(argument: String) {
        self.init(argument)
    }
}
