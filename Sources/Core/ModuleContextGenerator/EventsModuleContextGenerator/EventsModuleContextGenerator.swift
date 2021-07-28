//
//  EventsModuleContextGenerator.swift
//  
//
//  Created by Alexander Filimonov on 14/03/2020.
//

/// Class for generating contexts for eventCategories
public final class EventsModuleContextGenerator: ModuleContextGenerator {

    // MARK: - Private Properties

    private let service: EventsAbstractService
    private let baseConfig: BaseConfig
    private let moduleConfig: ModuleConfig
    private let parameterMapper: ParameterMapper

    private var eventCategories: [EventCategory]?

    // MARK: - Initialization

    /// Initializer for class
    /// - Parameters:
    ///   - service: service for getting eventCategories
    ///   - baseConfig: base config
    ///   - moduleConfig: module config
    ///   - parameterMapper: parameter mapper
    public init(service: EventsAbstractService,
                baseConfig: BaseConfig,
                moduleConfig: ModuleConfig,
                parameterMapper: ParameterMapper) {
        self.service = service
        self.baseConfig = baseConfig
        self.moduleConfig = moduleConfig
        self.parameterMapper = parameterMapper
    }

    // MARK: - Public Methods

    public func getEvents() throws -> [EventCategory] {
        try tryGetEventsFromService()
        return eventCategories ?? []
    }

    // MARK: - ModuleContextGenerator

    /// Method for generating constexts
    public func generate() throws -> [FileContext] {
        try tryGetEventsFromService()
        return try eventCategories?.map {
            try EventCategoryContextGenerator(input: $0,
                                              baseConfig: baseConfig,
                                              moduleConfig: moduleConfig,
                                              parameterMapper: parameterMapper).generate()
        } ?? []
    }

}

// MARK: - Private Methods

private extension EventsModuleContextGenerator {

    func tryGetEventsFromService() throws {
        guard eventCategories == nil else {
            return
        }
        self.eventCategories = try service.getEvents()
    }

}
