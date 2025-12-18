//
//  AnimatedCircle.swift
//  SosView.swift
//
//  Created by AFP FED 11 on 18/12/25.
//


import SwiftUI

struct AnimatedCircle: View {
    var color: Color
    @Binding var isAnimating: Bool
    var icon: String

    var body: some View {
        Circle()
            .fill(color)
            .frame(width: isAnimating ? 90 : 84,
                   height: isAnimating ? 90 : 84)
            .shadow(color: color.opacity(0.9),
                    radius: isAnimating ? 16 : 8)
            .overlay(
                Image(systemName: icon)
                    .font(.system(size: 30))
                    .foregroundColor(.white)
            )
    }
}
