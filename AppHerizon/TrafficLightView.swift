
//
//  TrafficLightView.swift
//  SosView.swift
//
//  Created by AFP FED 11 on 16/12/25.
//

import SwiftUI

struct TrafficLightView: View {

    let color: Color
    let title: String
    let icon: String

    var body: some View {
        HStack(spacing: 20) {

            ZStack {
                Circle()
                    .fill(color)
                    .frame(width: 70, height: 70)

                Image(systemName: icon)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
            }

            Text(title)
                .foregroundColor(.white)
                .font(.headline)

            Spacer()
        }
        .padding(.horizontal)
    }
}
