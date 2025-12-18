//
//  TrafficAction.swift
//  SosView.swift
//
//  Created by AFP FED 11 on 18/12/25.
//
import SwiftUI

enum trafficAction {
    case helpers
    case fakeCall
    case safePlace

    var color: Color {
        switch self {
        case .helpers: return .green
        case .fakeCall: return .yellow
        case .safePlace: return .red
        }
    }

    var icon: String {
        switch self {
        case .helpers: return "person.3.fill"
        case .fakeCall: return "phone.fill"
        case .safePlace: return "location.fill"
        }
    }

    var label: String {
        switch self {
        case .helpers: return "Find Helpers"
        case .fakeCall: return "Fake Call"
        case .safePlace: return "Safe Place"
        }
    }
}

