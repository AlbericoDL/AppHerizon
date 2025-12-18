//
//  SwipeToCallView.swift
//  SosView.swift
//
//  Created by AFP FED 11 on 16/12/25.
//

import SwiftUI

struct SwipeToCall2: View {

    @Binding var dragOffset: CGFloat
    let maxDrag: CGFloat
    let onComplete: () -> Void

    var body: some View {
        ZStack {

            Capsule()
                .fill(Color.pink.opacity(0.3))
                .frame(height: 60)

            Text("Swipe to call emergency")
                .foregroundColor(.white)
                .opacity(dragOffset == 0 ? 1 : 0)

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
                                let x = value.translation.width
                                if x > 0 && x <= maxDrag {
                                    dragOffset = x
                                }
                            }
                            .onEnded { _ in
                                if dragOffset > maxDrag * 0.8 {
                                    // Chiamata simulata: attiva la callback
                                    onComplete()
                                }
                                withAnimation(.easeOut) {
                                    dragOffset = 0
                                }
                            }
                    )

                Spacer()
            }
            .padding(.horizontal, 2)
        }
        .frame(width: 350)
    }
}
