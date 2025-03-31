//
//  ExcerciseSet.swift
//  GymLog
//
//  Created by Zain Ghosheh on 3/26/25.
//
import Foundation
import SwiftData

@Model
class ExerciseSet {
    var reps: Int
    var weight: Double
    var completed: Bool

    init(reps: Int, weight: Double, completed: Bool = false) {
        self.reps = reps
        self.weight = weight
        self.completed = completed
    }
}
