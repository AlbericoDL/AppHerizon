import SwiftUI

struct FakeCallView: View {

    @State private var isCalling = true
    @State private var callAnswered = false
    @State private var callDuration: Int = 0
    @State private var timer: Timer?

    var body: some View {
        VStack(spacing: 30) {

            Spacer()

            if callAnswered {
                // Vista durante la chiamata
                VStack(spacing: 12) {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.pink)
                    
                    Text("Jessica Doe")
                        .font(.largeTitle.bold())
                    
                    Text("00:\(String(format: "%02d", callDuration))")
                        .font(.title2.monospacedDigit())
                        .foregroundColor(.gray)
                }
            } else {
                // Vista “in arrivo”
                Image(systemName: "phone.arrow.up.right")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.red)

                Text("Jessica Doe")
                    .font(.largeTitle.bold())

                Text("Help me…")
                    .font(.title3)
                    .foregroundColor(.gray)
            }

            Spacer()

            HStack(spacing: 60) {

                if callAnswered {
                    // pulsante fine chiamata
                    Button(action: endCall) {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 80, height: 80)
                            .overlay(
                                Image(systemName: "phone.down.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                            )
                    }
                } else {
                    // pulsante rispondi
                    Button(action: answerCall) {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 80, height: 80)
                            .overlay(
                                Image(systemName: "phone.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                            )
                    }

                    // pulsante rifiuta
                    Button(action: endCall) {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 80, height: 80)
                            .overlay(
                                Image(systemName: "phone.down.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                            )
                    }
                }
            }
            .padding(.bottom, 60)
        }
        .onDisappear {
            stopTimer()
        }
    }

    // MARK: - Actions

    private func answerCall() {
        callAnswered = true
        startTimer()
    }

    private func endCall() {
        callAnswered = false
        stopTimer()
    }

    private func startTimer() {
        callDuration = 0
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            callDuration += 1
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

