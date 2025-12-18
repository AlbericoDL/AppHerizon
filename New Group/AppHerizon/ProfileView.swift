import SwiftUI

struct ProfileView: View {

    @AppStorage("userName") private var userName: String = "My Name"
    @AppStorage("nameQuote") private var nameQuote: String = "my name quote"
    @AppStorage("email") private var email: String = "example@email.com"
    @AppStorage("birthday") private var birthday: String = "12 Aprile 1998"
    @AppStorage("isTraveller") private var isTraveller: Bool = true
    @AppStorage("avatarData") private var avatarData: Data = Data()

    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?

    var body: some View {
        ZStack {
            // Sfondo bianco
            Color.white
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {
                    // MARK: Avatar + Nome
                    VStack(spacing: 12) {
                        ZStack(alignment: .bottomTrailing) {
                            Image(uiImage: avatarImage())
                                .resizable()
                                .scaledToFill()
                                .frame(width: 130, height: 130)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                                .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 2))
                                .onTapGesture {
                                    showingImagePicker = true
                                }

                            // Pulsante piccola fotocamera
                            Image(systemName: "camera.fill")
                                .foregroundColor(.white)
                                .padding(6)
                                .background(Color.blue)
                                .clipShape(Circle())
                                .shadow(radius: 2)
                                .offset(x: 5, y: 5)
                        }

                        TextField("Enter your name", text: $userName)
                            .font(.title2)
                            .bold()
                            .multilineTextAlignment(.center)
                            .padding(8)
                            .background(Color.pink.opacity(0.8))
                            .cornerRadius(10)
                            .frame(maxWidth: 280)

                        TextField("Enter your quote", text: $nameQuote)
                            .font(.title3)
                            .italic()
                            .multilineTextAlignment(.center)
                            .padding(6)
                            .background(Color.pink.opacity(0.8))
                            .cornerRadius(8)
                            .frame(maxWidth: 280)
                    }
                    .padding(.top, 40)

                    // MARK: Info personali in Card
                    VStack(spacing: 16) {
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundColor(.pink)
                            TextField("Birthday", text: $birthday)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }

                        HStack {
                            Image(systemName: "envelope")
                                .foregroundColor(.blue)
                            TextField("Email", text: $email)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }

                        Toggle(isOn: $isTraveller) {
                            Text(isTraveller ? "Traveller" : "Helper")
                                .bold()
                                .foregroundColor(.pink)
                        }
                        .toggleStyle(SwitchToggleStyle(tint: .pink))
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(15)
                    .padding(.horizontal, 24)

                    Spacer()
                }
                .padding(.bottom, 40)
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $inputImage)
        }
    }

    // MARK: Avatar image
    private func avatarImage() -> UIImage {
        if let img = UIImage(data: avatarData), !img.size.equalTo(.zero) {
            return img
        }
        // fallback immagine da Assets
        return UIImage(named: "profile_avatar") ?? UIImage(systemName: "person.circle.fill")!
    }

    private func loadImage() {
        guard let inputImage = inputImage else { return }
        avatarData = inputImage.jpegData(compressionQuality: 0.8) ?? Data()
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

// MARK: Preview
#Preview {
    ProfileView()
}

