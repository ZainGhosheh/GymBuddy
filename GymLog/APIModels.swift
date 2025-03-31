import Foundation

// Represents an exercise from the Wger API
struct Exercise: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String
}

// Top-level response from the API
struct ExerciseResponse: Codable {
    let results: [Exercise]
}
