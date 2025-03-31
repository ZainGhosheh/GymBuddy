//
//  Workout.swift
//  GymLog
//
//  Created by Zain Ghosheh on 3/26/25.
//

import Foundation
import SwiftData

@Model
class Workout {
    var name: String
    var date: Date
    var bio: String
    var exercises: [WorkoutExercise]

    init(name: String, date: Date = .now, bio: String, exercises: [WorkoutExercise] = []) {
        self.name = name
        self.date = date
        self.bio = bio
        self.exercises = exercises
    }
}
