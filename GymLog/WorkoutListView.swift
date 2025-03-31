//
//  WorkoutListView.swift
//  GymLog
//
//  Created by Zain Ghosheh on 3/26/25.
//

import SwiftUI
import SwiftData

struct WorkoutListView: View {
    @Environment(\.modelContext) private var context
    @Query private var workouts: [Workout]
    @State private var showingAddWorkout = false

    var body: some View {
        List {
            ForEach(workouts) { workout in
                NavigationLink(destination: WorkoutDetailView(workout: workout)) {
                    VStack(alignment: .leading) {
                        Text(workout.name).font(.headline)
                        Text(workout.date.formatted()).font(.subheadline)
                    }
                }
            }
            .onDelete(perform: deleteWorkouts)
        }
        .navigationTitle("My Workouts")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showingAddWorkout = true
                }) {
                    Label("Add Workout", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddWorkout) {
            AddWorkoutView()
        }
    }

    private func deleteWorkouts(at offsets: IndexSet) {
        for index in offsets {
            context.delete(workouts[index])
        }
    }
}
