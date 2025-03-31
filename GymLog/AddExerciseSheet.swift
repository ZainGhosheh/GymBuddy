//
//  AddExerciseSheet.swift
//  GymLog
//
//  Created by Zain Ghosheh on 3/26/25.
//

import SwiftUI

struct AddExerciseSheet: View {
    @Environment(\.dismiss) private var dismiss

    @State private var exerciseName: String = ""
    @State private var numberOfSets: Int = 3 {
        didSet { adjustSetInputs() }
    }
    @State private var defaultReps: Int = 8
    @State private var defaultWeight: Double = 135.0
    @State private var customizeSets: Bool = false
    @State private var setInputs: [SetInput] = []

    var onSave: (WorkoutExercise) -> Void

    struct SetInput: Identifiable {
        let id = UUID()
        var reps: Int
        var weight: Double
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Exercise Name")) {
                    TextField("e.g. Leg Press", text: $exerciseName)
                }

                Section(header: Text("Set Details")) {
                    Stepper("Number of Sets: \(numberOfSets)", value: $numberOfSets, in: 1...10)
                    Stepper("Default Reps: \(defaultReps)", value: $defaultReps, in: 1...20)
                    Stepper("Default Weight: \(defaultWeight, specifier: "%.1f") lbs", value: $defaultWeight, in: 0...1000, step: 5)

                    Toggle("Customize Sets", isOn: $customizeSets)
                }

                if customizeSets {
                    Section(header: Text("Customize Each Set")) {
                        ForEach($setInputs) { $set in
                            VStack(alignment: .leading) {
                                Text("Set \($setInputs.firstIndex(where: { $0.id == set.id })! + 1)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)

                                Stepper("Reps: \(set.reps)", value: $set.reps, in: 1...20)
                                Stepper("Weight: \(set.weight, specifier: "%.1f") lbs", value: $set.weight, in: 0...1000, step: 5)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
            .navigationTitle("Add Exercise")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        let sets: [ExerciseSet]
                        if customizeSets {
                            sets = setInputs.map { ExerciseSet(reps: $0.reps, weight: $0.weight) }
                        } else {
                            sets = (0..<numberOfSets).map { _ in
                                ExerciseSet(reps: defaultReps, weight: defaultWeight)
                            }
                        }
                        let newExercise = WorkoutExercise(name: exerciseName, sets: sets)
                        onSave(newExercise)
                        dismiss()
                    }
                    .disabled(exerciseName.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
            .onAppear {
                adjustSetInputs()
            }
        }
    }

    private func adjustSetInputs() {
        if setInputs.count < numberOfSets {
            for _ in setInputs.count..<numberOfSets {
                setInputs.append(SetInput(reps: defaultReps, weight: defaultWeight))
            }
        } else if setInputs.count > numberOfSets {
            setInputs = Array(setInputs.prefix(numberOfSets))
        }
    }
}
