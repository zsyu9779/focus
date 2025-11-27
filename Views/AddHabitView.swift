import SwiftUI
import SwiftData

struct AddHabitView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var duration = 30
    @State private var selectedPetType: PetType = .cat
    @State private var petName = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("Habit Details") {
                    TextField("Habit Name (e.g., Reading)", text: $name)
                    Stepper("Duration: \(duration) mins", value: $duration, in: 5...120, step: 5)
                }
                
                Section("Choose Your Companion") {
                    Picker("Pet Type", selection: $selectedPetType) {
                        ForEach(PetType.allCases, id: \.self) { type in
                            Text(type.rawValue.capitalized).tag(type)
                        }
                    }
                    TextField("Pet Name", text: $petName)
                }
            }
            .navigationTitle("New Journey")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Start") {
                        addHabit()
                    }
                    .disabled(name.isEmpty || petName.isEmpty)
                }
            }
        }
    }
    
    private func addHabit() {
        let newHabit = Habit(name: name, targetDurationMinutes: duration)
        let newPet = Pet(name: petName, type: selectedPetType)
        newHabit.pet = newPet
        
        modelContext.insert(newHabit)
        dismiss()
    }
}
