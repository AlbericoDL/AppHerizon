//
//  EmergencySimulationView.swift
//  SosView.swift
//
//  Created by AFP FED 11 on 18/12/25.
//

import SwiftUI
import CoreLocation

struct EmergencySimulationView: View {

    @State private var selectedOption: EmergencyOption? = nil
    @State private var showConfirmation = false

    // Simulated location (qui puoi usare dati reali da CoreLocation)
    @State private var simulatedLocation = "Lat: 40.7128, Lon: -74.0060"

    var body: some View {
        VStack(spacing: 30) {
            Text("Emergency")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)

            Text("Location:")
                .font(.headline)
            Text(simulatedLocation)
                .font(.subheadline)
                .foregroundColor(.gray)

            VStack(spacing: 16) {
                ForEach(EmergencyOption.allCases, id: \.self) { option in
                    Button {
                        selectedOption = option
                        showConfirmation = true
                    } label: {
                        HStack {
                            Image(systemName: option.icon)
                                .foregroundColor(.white)
                            Text(option.label)
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(option.color)
                        .cornerRadius(12)
                    }
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .alert("Confirm", isPresented: $showConfirmation) {
            Button("OK", role: .none) {
                // qui puoi espandere con logica
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Send request for \(selectedOption?.label ?? "")?")
        }
        .padding()
    }
}

enum EmergencyOption: CaseIterable {
    case medical
    case police
    case fire

    var label: String {
        switch self {
        case .medical: return "Medical Assistance"
        case .police: return "Police Help"
        case .fire: return "Fire Rescue"
        }
    }
    var icon: String {
        switch self {
        case .medical: return "cross.case.fill"
        case .police: return "shield.lefthalf.fill"
        case .fire: return "flame.fill"
        }
    }
    var color: Color {
        switch self {
        case .medical: return .red
        case .police: return .blue
        case .fire: return .orange
        }
    }
}
