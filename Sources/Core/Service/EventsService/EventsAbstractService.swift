//
//  EventsAbstractService.swift
//  
//
//  Created by Alexander Filimonov on 14/03/2020.
//

/// Service for getting eventCategories
public protocol EventsAbstractService {
    func getEvents() throws -> [EventCategory]
}
