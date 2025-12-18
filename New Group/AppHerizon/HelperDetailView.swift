//
//  HelperDetailView.swift
//  SosView.swift
//
//  Created by AFP FED 11 on 18/12/25.
//

import SwiftUI

struct HelperDetailView: View {

    let name: String

    @State private var showActionSheet = false

    var body: some View {
        VStack(spacing: 32) {

            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 140, height: 140)
                .foregroundColor(.green)
                .padding(.top, 60)

            Text(name)
                .font(.largeTitle)
                .fontWeight(.bold)

            Divider()

            Button(action: {
                showActionSheet = true
            }) {
                Text("Contact \(name)")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Spacer()
        }
        .padding()
        .navigationTitle(name)
        .navigationBarTitleDisplayMode(.inline)
        .confirmationDialog(
            "Contact \(name)",
            isPresented: $showActionSheet
        ) {
            Button("📞 Call") {
                // TODO: chiamata reale
                print("📞 Chiamata a \(name)")
            }
            Button("💬 Message") {
                // TODO: messaggio
                print("💬 Messaggio a \(name)")
            }
            Button("Cancel", role: .cancel) {}
        }
    }
}
