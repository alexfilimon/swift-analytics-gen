//
//  Path.swift
//  
//
//  Created by Alexander Filimonov on 14/02/2020.
//

import Foundation
import PathKit

extension Path {
    var lastComponent: String {
        return components.last ?? ""
    }
}
