import Foundation
import SwiftData

@Model
final class FocusSession {
    var id: UUID
    var startTime: Date
    var endTime: Date?
    var durationMinutes: Int
    var isCompleted: Bool
    
    @Relationship(inverse: \Habit.sessions) var habit: Habit?
    
    init(startTime: Date, durationMinutes: Int) {
        self.id = UUID()
        self.startTime = startTime
        self.durationMinutes = durationMinutes
        self.isCompleted = false
    }
}
