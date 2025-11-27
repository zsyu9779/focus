import SwiftUI
import SwiftData

struct ForestView: View {
    @Query(sort: \Pet.birthDate, order: .reverse) private var pets: [Pet]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 20) {
                    ForEach(pets) { pet in
                        VStack {
                            Text(pet.isAlive ? "🌳" : "🪦")
                                .font(.system(size: 50))
                            Text(pet.name)
                                .font(.caption)
                                .bold()
                            Text(pet.habit?.name ?? "Unknown")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)
                    }
                }
                .padding()
            }
            .navigationTitle("My Forest")
        }
    }
}
