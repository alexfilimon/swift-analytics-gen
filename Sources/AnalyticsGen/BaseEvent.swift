//
//  BaseEvent.swift
//  
//
//  Created by Alexander Filimonov on 11/03/2020.
//

import Foundation

class BaseEvent: AnalyticsEvent {

    init(name: String, params: [String: Any]) {}

}

protocol AnalyticsEvent {}
