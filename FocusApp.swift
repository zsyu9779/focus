import SwiftUI
import SwiftData

@main
struct FocusApp: App {
    let container: ModelContainer
    
    init() {
        do {
            let schema = Schema([
                Habit.self,
                Pet.self,
                FocusSession.self
            ])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            
            container = try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}
