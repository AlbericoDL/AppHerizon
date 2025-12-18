import SwiftUI

struct HelpersListView: View {

    let helpers = ["Alice", "Bob", "Carla", "Davide"]

    var body: some View {
        List(helpers, id: \.self) { helper in
            NavigationLink(destination: HelperDetailView(name: helper)) {
                HStack(spacing: 12) {
                    Image(systemName: "person.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.green)
                    Text(helper)
                        .font(.headline)
                }
                .padding(.vertical, 6)
            }
        }
        .navigationTitle("Find Helpers")
    }
}
