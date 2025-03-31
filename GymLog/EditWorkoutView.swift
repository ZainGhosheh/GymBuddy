//
//  EditWorkoutView.swift
//  GymLog
//
//  Created by Zain Ghosheh on 3/26/25.
import SwiftUI
import SwiftData

struct EditWorkoutView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @Bindable var workout: Workout

    var body: some View {
        NavigationStack {
            Form {
                // Workout Name & Notes
                Section(header: Text("Workout Info")) {
                    TextField("Workout Name", text: $workout.name)
                    TextField("Workout Notes", text: $workout.bio, axis: .vertical)
                }

                // Exercises & Sets
                Section(header: Text("Exercises")) {
                    ForEach($workout.exercises) { $exercise in
                        VStack(alignment: .leading) {
                            TextField("Exercise Name", text: $exercise.name)
                                .font(.headline)

                            ForEach($exercise.sets) { $set in
                                VStack(alignment: .leading, spacing: 6) {
                                    Stepper("Reps: \(set.reps)", value: $set.reps, in: 1...20)
                                    Stepper("Weight: \(set.weight, specifier: "%.1f") lbs", value: $set.weight, in: 0...1000, step: 5)
                                }
                                .padding(.vertical, 4)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }

                // Save Button
                Button("Save Changes") {
                    try? context.save()
                    dismiss()
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .navigationTitle("Edit Workout")
        }
    }
}
