//
//  SwipeToCallView.swift
//  SosView.swift
//
//  Created by AFP FED 11 on 16/12/25.
//
import SwiftUI

struct SwipeToCallView: View {

    @Binding var dragOffset: CGFloat
    let maxDrag: CGFloat
    let onComplete: () -> Void

    var body: some View {
        ZStack {

            Capsule()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 60)

            Text("Swipe to call emergency")
                .foregroundColor(.white)
                .font(.subheadline)

            HStack {
                Circle()
                    .fill(Color.red)
                    .frame(width: 52, height: 52)
                    .overlay(
                        Image(systemName: "phone.fill")
                            .foregroundColor(.white)
                    )
                    .offset(x: dragOffset)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let translation = value.translation.width
                                if translation > 0 && translation <= maxDrag {
                                    dragOffset = translation
                                }
                            }
                            .onEnded { _ in
                                if dragOffset > maxDrag * 0.8 {
                                    onComplete()
                                }
                                withAnimation(.easeOut) {
                                    dragOffset = 0
                                }
                            }
                    )

                Spacer()
            }
            .padding(.horizontal, 5)
        }
        .frame(width: 320)
    }
}

