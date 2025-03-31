import SwiftUI
import SwiftData

struct AddWorkoutView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State private var name: String = ""
    @State private var bio: String = ""
    @State private var showingAddExercise = false
    @State private var exercises: [WorkoutExercise] = []

    var body: some View {
        NavigationStack {
            Form {
                // Workout Info Section
                Section(header: Text("Workout Info")) {
                    TextField("Workout Name", text: $name)
                    TextField("Workout Notes", text: $bio, axis: .vertical)
                }

                // Exercises Section
                Section(header: Text("Exercises")) {
                    ForEach(exercises) { exercise in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(exercise.name)
                                .font(.headline)

                            ForEach(exercise.sets) { set in
                                Text("Set: \(set.reps) reps @ \(set.weight, specifier: "%.1f") lbs")
                                    .font(.subheadline)
                            }

                            Button("Add Set") {
                                let newSet = ExerciseSet(reps: 8, weight: 135)
                                exercise.sets.append(newSet)
                            }
                            .font(.caption)
                        }
                        .padding(.vertical, 6)
                    }

                    Button("Add Exercise") {
                        showingAddExercise = true
                    }
                }

                // Save Button
                Section {
                    Button("Save Workout") {
                        let newWorkout = Workout(name: name, bio: bio, exercises: exercises)
                        context.insert(newWorkout)
                        dismiss()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .navigationTitle("Add Workout")
            .sheet(isPresented: $showingAddExercise) {
                AddExerciseSheet { newExercise in
                    exercises.append(newExercise)
                }
            }
        }
    }
}
