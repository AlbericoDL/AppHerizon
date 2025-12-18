//
//  SOSView.swift
//  SosView.swift
//
//  Created by AFP FED 11 on 18/12/25.
//

import SwiftUI

struct SOSView2: View {

    @State private var dragOffset: CGFloat = 0
    @State private var showEmergencySim = false

    // Navigation states per i pulsanti semaforo
    @State private var showHelpers = false
    @State private var showFakeCall = false
    @State private var showSafePlace = false

    private let maxDrag: CGFloat = 200

    // Stati per animazioni pulsanti
    @State private var animateGreen = false
    @State private var animateYellow = false
    @State private var animateRed = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()

                VStack {
                    // Titolo SOS in alto
                    Text("SOS")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        .padding(.top, 40)

                    Spacer()

                    // 📶 Semaforo verticale
                    ZStack {
                        RoundedRectangle(cornerRadius: 45)
                            .fill(Color.gray.opacity(0.25))
                            .frame(width: 140, height: 430)

                        VStack(spacing: 32) {

                            // 🔵 GREEN CIRCLE: Find Helpers
                            Button {
                                showHelpers = true
                            } label: {
                                VStack(spacing: 8) {
                                    AnimatedCircle(color: .green, isAnimating: $animateGreen, icon: "person.3.fill")
                                    Text("Find Helpers")
                                        .font(.caption)
                                        .foregroundColor(.white)
                                }
                            }

                            // ⚠️ YELLOW CIRCLE: Fake Call
                            Button {
                                showFakeCall = true
                            } label: {
                                VStack(spacing: 8) {
                                    AnimatedCircle(color: .yellow, isAnimating: $animateYellow, icon: "phone.fill")
                                    Text("Fake Call")
                                        .font(.caption)
                                        .foregroundColor(.white)
                                }
                            }

                            // 🔴 RED CIRCLE: Safe Places
                            Button {
                                showSafePlace = true
                            } label: {
                                VStack(spacing: 8) {
                                    AnimatedCircle(color: .red, isAnimating: $animateRed, icon: "location.fill")
                                    Text("Safe Places")
                                        .font(.caption)
                                        .foregroundColor(.white)
                                }
                            }

                        }
                    }
                    .padding(.vertical, 30)

                    Spacer()

                    // 🚨 SWIPE per emergenza simulata
                    SwipeToCall(dragOffset: $dragOffset, maxDrag: maxDrag) {
                        showEmergencySim = true
                    }
                    .padding(.bottom, 40)

                }
                .padding(.horizontal, 20)
                .onAppear {
                    startAnimations()
                }

                // NAVIGATIONLINK invisibili per ciascun pulsante
                NavigationLink("", isActive: $showHelpers) {
                    HelpersListView()
                }
                NavigationLink("", isActive: $showFakeCall) {
                    FakeCallView()
                }
                NavigationLink("", isActive: $showSafePlace) {
                    SafePlacesView()
                }
                NavigationLink("", isActive: $showEmergencySim) {
                    EmergencySimulationView()
                }
            }
        }
    }

    // MARK: Animazioni a loop sui cerchi
    private func startAnimations() {
        withAnimation(Animation.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
            animateGreen.toggle()
        }
        withAnimation(Animation.easeInOut(duration: 1.4).repeatForever(autoreverses: true)) {
            animateYellow.toggle()
        }
        withAnimation(Animation.easeInOut(duration: 1.6).repeatForever(autoreverses: true)) {
            animateRed.toggle()
        }
    }
}
