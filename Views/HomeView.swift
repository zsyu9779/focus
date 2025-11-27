import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(filter: #Predicate<Habit> { !$0.isArchived }, sort: \Habit.createdAt) private var habits: [Habit]
    
    @State private var showAddHabitSheet = false
    
    var body: some View {
        NavigationView {
            List {
                if habits.isEmpty {
                    ContentUnavailableView("No Habits Yet", systemImage: "sparkles", description: Text("Start a new journey to grow your pet."))
                } else {
                    ForEach(habits) { habit in
                        NavigationLink(destination: FocusView(habit: habit)) {
                            HabitRow(habit: habit)
                        }
                    }
                    .onDelete(perform: deleteHabits)
                }
            }
            .navigationTitle("My Habits")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showAddHabitSheet = true }) {
                        Label("Add Habit", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddHabitSheet) {
                AddHabitView()
            }
        }
    }
    
    private func deleteHabits(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(habits[index])
            }
        }
    }
}

struct HabitRow: View {
    let habit: Habit
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(habit.name)
                    .font(.headline)
                Text("\(habit.targetDurationMinutes) mins / day")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            if let pet = habit.pet {
                Text(pet.stage.rawValue.capitalized) // Simple text representation for now
                    .padding(6)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)
            }
        }
        .padding(.vertical, 4)
    }
}
