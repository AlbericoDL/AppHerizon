import SwiftUI

struct BackSemaphoreButton: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "trafficlight.fill")
                .font(.title2)
                .foregroundColor(.primary)
        }
    }
}
