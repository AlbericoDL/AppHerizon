//
//  SafePlaceView.swift
//  SosView.swift
//
//  Created by AFP FED 11 on 18/12/25.
//

import SwiftUI
import MapKit

// MARK: Safe Place Model
struct SafePlace: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct SafePlacesView: View {
    
    // Regione iniziale (centra la mappa su un punto di default)
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    // Lista di Safe Places (esempio statico, puoi sostituire con dati reali)
    @State private var safePlaces: [SafePlace] = [
        SafePlace(name: "Community Safe Zone", coordinate: CLLocationCoordinate2D(latitude: 40.730610, longitude: -73.935242)),
        SafePlace(name: "City Shelter", coordinate: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060)),
        SafePlace(name: "Police Station", coordinate: CLLocationCoordinate2D(latitude: 40.7282, longitude: -73.7949)),
        SafePlace(name: "24/7 Secure Café", coordinate: CLLocationCoordinate2D(latitude: 40.7411, longitude: -73.9897))
    ]
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: safePlaces) { place in
            MapAnnotation(coordinate: place.coordinate) {
                VStack(spacing: 4) {
                    Image(systemName: "mappin.circle.fill")
                        .font(.title2)
                        .foregroundColor(.blue)
                    
                    Text(place.name)
                        .font(.caption2)
                        .fixedSize()
                        .foregroundColor(.primary)
                }
            }
        }
        .navigationTitle("Safe Places")
        .navigationBarTitleDisplayMode(.inline)
        .edgesIgnoringSafeArea(.all)
    }
}
