//
//  ContentView.swift
//  ProfileView.swift
//
//  Created by AFP FED 11 on 16/12/25.
//

import SwiftUI

// MARK: Modello colore per salvataggio
struct ThemeColor: Codable {
    let red: Double
    let green: Double
    let blue: Double
}

struct ProfileView: View {

    // MARK: Stato persistente
    @AppStorage("userName") private var userName: String = "My Name"
    @AppStorage("nameQuote") private var nameQuote: String = "my name quote"
    @AppStorage("email") private var email: String = "example@email.com"
    @AppStorage("birthday") private var birthday: String = "12 Aprile 1998"
    @AppStorage("isTraveller") private var isTraveller: Bool = true

    // Avatar salvato come Data
    @AppStorage("avatarData") private var avatarData: Data = Data()

    // Colori dei temi salvati come Data (JSON)
    @AppStorage("themeColorsData") private var themeColorsData: Data = Data()

    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?

    var body: some View {

        // Binding tema colori
        let themeColors = Binding(
            get: {
                decodeColors(from: themeColorsData)
            },
            set: { newColors in
                themeColorsData = encodeColors(newColors)
            }
        )

        ZStack {
            // *** Sfondo rosa ***
            Color.pink
                .opacity(0.5)
                .ignoresSafeArea()

            VStack(spacing: 24) {

                // MARK: Header — Avatar + Nome + Quote
                VStack(spacing: 12) {

                    Image(uiImage: avatarImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.white, lineWidth: 3)
                        )
                        .shadow(radius: 5)
                        .onTapGesture {
                            showingImagePicker = true
                        }

                    TextField("Enter your name", text: $userName)
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(.roundedBorder)
                        .frame(maxWidth: 280)

                    TextField("Enter your quote", text: $nameQuote)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(.roundedBorder)
                        .frame(maxWidth: 280)
                }
                .padding(.top, 40)

                // MARK: Temi / Colori
                VStack(alignment: .leading, spacing: 16) {

                    Text("Temi / Colori")
                        .font(.headline)
                        .foregroundColor(.white)

                    HStack(spacing: 12) {
                        ForEach(0..<themeColors.wrappedValue.count, id: \.self) { i in
                            Circle()
                                .fill(themeColors.wrappedValue[i])
                                .frame(width: 30, height: 30)
                                .onTapGesture {
                                    var arr = themeColors.wrappedValue
                                    arr[i] = Color(
                                        red: .random(in: 0...1),
                                        green: .random(in: 0...1),
                                        blue: .random(in: 0...1)
                                    )
                                    themeColors.wrappedValue = arr
                                }
                        }
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Informazioni")
                            .font(.headline)
                            .foregroundColor(.white)

                        TextField("Compleanno", text: $birthday)
                            .textFieldStyle(.roundedBorder)

                        TextField("Email", text: $email)
                            .textFieldStyle(.roundedBorder)
                    }
                }
                .padding(.horizontal, 24)

                Spacer()

                // MARK: Toggle Traveller / Helper
                VStack(spacing: 12) {
                    Text(isTraveller ? "Traveller" : "Helper")
                        .font(.headline)
                        .foregroundColor(isTraveller ? .green : .white)

                    Toggle("", isOn: $isTraveller)
                        .toggleStyle(SwitchToggleStyle(tint: .white))
                        .labelsHidden()
                }
                .padding(.bottom, 40)

            } // VStack principale
        } // ZStack
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $inputImage)
        }
    }

    // MARK: Funzioni avatar
    private func avatarImage() -> UIImage {
        if let img = UIImage(data: avatarData) {
            return img
        }
        return UIImage(named: "profile_avatar") ?? UIImage(systemName: "person.circle.fill")!
    }

    private func loadImage() {
        guard let inputImage = inputImage else { return }
        avatarData = inputImage.jpegData(compressionQuality: 0.8) ?? Data()
    }
}

// MARK: Preview
#Preview {
    ContentView()
}

// MARK: Encoding / Decoding dei temi
func encodeColors(_ colors: [Color]) -> Data {
    let codable = colors.map {
        let comps = $0.components()
        return ThemeColor(red: comps.red, green: comps.green, blue: comps.blue)
    }
    return (try? JSONEncoder().encode(codable)) ?? Data()
}

func decodeColors(from data: Data) -> [Color] {
    if let decoded = try? JSONDecoder().decode([ThemeColor].self, from: data) {
        return decoded.map { Color(red: $0.red, green: $0.green, blue: $0.blue) }
    }
    return [Color.blue, Color.green, Color.orange, Color.purple]
}

// MARK: Color → RGB helper
extension Color {
    func components() -> (red: Double, green: Double, blue: Double) {
        let uiColor = UIColor(self)
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0
        uiColor.getRed(&r, green: &g, blue: &b, alpha: nil)
        return (Double(r), Double(g), Double(b))
    }
}

// MARK: ImagePicker wrapper
struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.dismiss) var dismiss
    @Binding var image: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }

    func updateUIViewController(_: UIImagePickerController, context _: Context) { }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        init(_ parent: ImagePicker) { self.parent = parent }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.dismiss()
        }
    }
}
