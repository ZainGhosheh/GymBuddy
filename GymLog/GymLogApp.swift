//
//  GymLogApp.swift
//  GymLog
//
//  Created by Zain Ghosheh on 3/26/25.
//
import SwiftUI
import SwiftData

@main
struct GymLogApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Workout.self)
    }
}

