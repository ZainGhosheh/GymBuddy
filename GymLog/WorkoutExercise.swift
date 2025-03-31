//
//  WorkoutExercise.swift
//  GymLog
//
//  Created by Zain Ghosheh on 3/26/25.
//
import Foundation
import SwiftData

@Model
class WorkoutExercise {
    var name: String
    var sets: [ExerciseSet]

    init(name: String, sets: [ExerciseSet] = []) {
        self.name = name
        self.sets = sets
    }
}
