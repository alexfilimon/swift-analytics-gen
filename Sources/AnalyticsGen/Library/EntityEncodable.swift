//
//  EntityEncodable.swift
//  
//
//  Created by Alexander Filimonov on 14/02/2020.
//

import Foundation

protocol EntityEncodable {
    associatedtype Entity
    func toEntity() throws -> Entity
}
