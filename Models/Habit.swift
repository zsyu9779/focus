import Foundation
import SwiftData

@Model
final class Habit {
    var id: UUID
    var name: String
    var targetDurationMinutes: Int
    var createdAt: Date
    var isArchived: Bool
    
    // Relationship to Pet
    @Relationship(deleteRule: .cascade) var pet: Pet?
    
    // Relationship to FocusSessions
    @Relationship(deleteRule: .cascade) var sessions: [FocusSession] = []
    
    init(name: String, targetDurationMinutes: Int) {
        self.id = UUID()
        self.name = name
        self.targetDurationMinutes = targetDurationMinutes
        self.createdAt = Date()
        self.isArchived = false
    }
}
