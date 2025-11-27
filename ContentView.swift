import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            ForestView()
                .tabItem {
                    Label("Forest", systemImage: "leaf.fill")
                }
        }
    }
}
