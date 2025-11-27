import Foundation
import SwiftData

enum PetType: String, Codable, CaseIterable {
    case cat
    case dog
    case owl
    case plant
}

enum PetStage: String, Codable {
    case egg
    case baby
    case child
    case adult
    case spirit // For dead pets
}

@Model
final class Pet {
    var id: UUID
    var name: String
    var type: PetType
    var stage: PetStage
    var birthDate: Date
    var lastFedDate: Date?
    var totalGrowthPoints: Int
    var isAlive: Bool
    var deathDate: Date?
    
    @Relationship(inverse: \Habit.pet) var habit: Habit?
    
    init(name: String, type: PetType) {
        self.id = UUID()
        self.name = name
        self.type = type
        self.stage = .egg
        self.birthDate = Date()
        self.totalGrowthPoints = 0
        self.isAlive = true
    }
    
    func feed() {
        self.lastFedDate = Date()
        self.totalGrowthPoints += 1
        checkGrowth()
    }
    
    func checkGrowth() {
        // Simple logic: 21 points to advance a stage
        if totalGrowthPoints >= 63 {
            stage = .adult
        } else if totalGrowthPoints >= 42 {
            stage = .child
        } else if totalGrowthPoints >= 21 {
            stage = .baby
        } else {
            stage = .egg
        }
    }
    
    func die() {
        self.isAlive = false
        self.stage = .spirit
        self.deathDate = Date()
    }
}
