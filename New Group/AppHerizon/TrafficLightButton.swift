//
//  TrafficLightButton.swift
//  SosView.swift
//
//  Created by AFP FED 11 on 18/12/25.
//

import SwiftUI

struct trafficLightButton: View {

    let action: TrafficAction
    @Binding var activeAction: TrafficAction?
    let onTap: () -> Void

    @State private var isPressed = false

    var body: some View {
        VStack(spacing: 6) {

            Button {
                handleTap()
                onTap()
            } label: {
                ZStack {
                    Circle()
                        .fill(action.color)
                        .frame(width: 120, height: 100)
                        .shadow(color: action.color.opacity(activeAction == action ? 0.9 : 0.5),
                                radius: activeAction == action ? 20 : 10)

                    Image(systemName: action.icon)
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.white)
                        .scaleEffect(isPressed ? 1.15 : 1.0)
                }
            }
            .buttonStyle(.plain)

            Text(action.label)
                .font(.caption)
                .foregroundColor(.white.opacity(0.85))
        }
    }

    private func handleTap() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            isPressed = true
            activeAction = action
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            withAnimation {
                isPressed = false
            }
        }
    }
}
