import SwiftUI

struct SOSView: View {

    // MARK: - States
    @State private var dragOffset: CGFloat = 0
    @State private var activeLight: TrafficAction? = nil

    private let maxDrag: CGFloat = 200

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 60) {

                Text("SOS")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)

                // MARK: - Traffic Light
                VStack(spacing: 30) {

                    TrafficLightButton(
                        action: .helpers,
                        activeAction: $activeLight
                    )

                    TrafficLightButton(
                        action: .fakeCall,
                        activeAction: $activeLight
                    )

                    TrafficLightButton(
                        action: .safePlace,
                        activeAction: $activeLight
                    )
                }
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 80)
                        .fill(Color.gray.opacity(0.2))
                )

                Spacer()

                SwipeToCall(
                    dragOffset: $dragOffset,
                    maxDrag: maxDrag,
                    onComplete: triggerEmergencyCall
                )
            }
            .padding()
        }
    }

    private func triggerEmergencyCall() {
        print("🚨 Emergency Call")
    }
}

//////////////////////////////////////////////////
// MARK: - Traffic Actions
//////////////////////////////////////////////////

enum TrafficAction {
    case helpers
    case fakeCall
    case safePlace

    var color: Color {
        switch self {
        case .helpers: return .green
        case .fakeCall: return .yellow
        case .safePlace: return .red
        }
    }

    var icon: String {
        switch self {
        case .helpers: return "person.3.fill"
        case .fakeCall: return "phone.fill"
        case .safePlace: return "location.fill"
        }
    }

    var label: String {
        switch self {
        case .helpers: return "Find Helpers"
        case .fakeCall: return "Fake Call"
        case .safePlace: return "Safe Place"
        }
    }
}

//////////////////////////////////////////////////
// MARK: - Traffic Light Button
//////////////////////////////////////////////////

struct TrafficLightButton: View {

    let action: TrafficAction
    @Binding var activeAction: TrafficAction?

    @State private var isPressed = false

    var body: some View {
        VStack(spacing: 6) {

            Button {
                handleTap()
            } label: {
                ZStack {
                    Circle()
                        .fill(action.color)
                        .frame(width: 120, height: 100)
                        .shadow(
                            color: action.color.opacity(
                                activeAction == action ? 0.9 : 0.5
                            ),
                            radius: activeAction == action ? 20 : 10
                        )

                    Image(systemName: action.icon)
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.white)
                        .scaleEffect(isPressed ? 1.2 : 1.0)
                }
            }
            .buttonStyle(.plain)

            Text(action.label)
                .font(.caption)
                .foregroundColor(.white.opacity(0.85))
        }
    }

    private func handleTap() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
            isPressed = true
            activeAction = action
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation {
                isPressed = false
            }
        }

        // MARK: - Action hook
        switch action {
        case .helpers:
            print("🟢 Find Helpers tapped")
        case .fakeCall:
            print("🟡 Fake Call tapped")
        case .safePlace:
            print("🔴 Safe Place tapped")
        }
    }
}

//////////////////////////////////////////////////
// MARK: - Swipe to Call
//////////////////////////////////////////////////

struct SwipeToCall: View {

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
                                    onComplete()
                                }
                                withAnimation(.easeOut) {
                                    dragOffset = 0
                                }
                            }
                    )

                Spacer()
            }
            .padding(.horizontal, 0)
        }
        .frame(width: 320)
    }
}

//////////////////////////////////////////////////
// MARK: - Preview
//////////////////////////////////////////////////

struct SOSView_Previews: PreviewProvider {
    static var previews: some View {
        SOSView()
    }
}

