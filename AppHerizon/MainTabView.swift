import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            CommunityView()
                .tabItem {
                    Label("Community", systemImage: "person.3.fill")
                }

            SuggestionsView()
                .tabItem {
                    Label("Suggestions", systemImage: "lightbulb.fill")
                }
            HomeMapView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            ChallengeView()
                .tabItem {
                    Label("Challenge", systemImage: "flag.fill")
                }

            MyTripView()
                .tabItem {
                    Label("My Trip", systemImage: "map.fill")
                }
        }
    }
}

