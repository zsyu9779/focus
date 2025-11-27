import SwiftUI
import SwiftData

struct FocusView: View {
    @Environment(\.modelContext) private var modelContext
    let habit: Habit
    
    @State private var isFocusing = false
    @State private var remainingSeconds: Int
    @State private var timer: Timer?
    @State private var showGiveUpAlert = false
    
    init(habit: Habit) {
        self.habit = habit
        _remainingSeconds = State(initialValue: habit.targetDurationMinutes * 60)
    }
    
    var body: some View {
        VStack(spacing: 40) {
            // Pet Display
            if let pet = habit.pet {
                VStack {
                    Text(pet.isAlive ? "🌱" : "🪦") // Placeholder for Pet Image
                        .font(.system(size: 100))
                    Text(pet.name)
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Stage: \(pet.stage.rawValue.capitalized)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            
            // Timer Display
            Text(timeString(time: remainingSeconds))
                .font(.system(size: 60, weight: .monospacedDigit))
                .contentTransition(.numericText())
            
            // Controls
            if !isFocusing {
                Button(action: startFocus) {
                    Text("Start Focus")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            } else {
                Button(action: { showGiveUpAlert = true }) {
                    Text("Give Up")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
        }
        .padding()
        .navigationTitle(habit.name)
        .alert("Give Up?", isPresented: $showGiveUpAlert) {
            Button("Cancel", role: .cancel) { }
            Button("I'm Sorry...", role: .destructive) {
                stopFocus(completed: false)
            }
        } message: {
            Text("Your pet will be sad if you stop now.")
        }
    }
    
    private func startFocus() {
        isFocusing = true
        // In a real app, this is where we would activate FamilyControls
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if remainingSeconds > 0 {
                remainingSeconds -= 1
            } else {
                stopFocus(completed: true)
            }
        }
    }
    
    private func stopFocus(completed: Bool) {
        timer?.invalidate()
        timer = nil
        isFocusing = false
        
        if completed {
            habit.pet?.feed()
            // Reset timer for next time (optional, or navigate away)
            remainingSeconds = habit.targetDurationMinutes * 60
        } else {
            // Penalty logic could go here
        }
    }
    
    private func timeString(time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
