//
//  SemaforoButtonView.swift
//  SosView.swift
//
//  Created by AFP FED 11 on 18/12/25.
//


import SwiftUI

struct SemaforoButtonView: View {
    var color: Color
    var icon: String
    var text: String

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(color)
                .frame(width: 52, height: 52)
                .overlay(
                    Image(systemName: icon)
                        .foregroundColor(.white)
                        .font(.title2)
                )

            Text(text)
                .font(.headline)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    SemaforoButtonView(color: .red, icon: "phone.fill", text: "Test")
}
