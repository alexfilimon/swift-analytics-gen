//
//  RawMapper.swift
//  
//
//  Created by Alexander Filimonov on 06/03/2020.
//

public class RawMapper<Model>: RawMappable {

    // MARK: - Private Properties

    public let model: Model
    public let config: Config
    public let payload: Payload

    // MARK: - Initialization

    public init(model: Model,
                config: Config,
                payload: Payload) {
        self.model = model
        self.config = config
        self.payload = payload
    }

    // MARK: - RawMappable

    public func toRaw() throws -> [String : Any] {
        fatalError("method \(#function) must be implemented")
    }

}
