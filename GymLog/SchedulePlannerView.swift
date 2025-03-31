import SwiftUI
import SwiftData

struct SchedulePlannerView: View {
    let daysOfWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

    @Query private var allWorkouts: [Workout]
    @State private var schedule: [String: Workout] = [:]
    @State private var selectedDay: String = ""
    @State private var showWorkoutPicker = false

    // Frequency Config
    @State private var legDays = 2
    @State private var pushDays = 2
    @State private var pullDays = 2
    @State private var cardioDays = 1
    @State private var restDays = 1
    @State private var showFrequencySetup = false

    var body: some View {
        List {
            // Weekly View
            Section(header: Text("Your Weekly Schedule")) {
                ForEach(daysOfWeek, id: \.self) { day in
                    HStack {
                        Text(day)
                            .frame(width: 50, alignment: .leading)

                        Spacer()

                        if let workout = schedule[day] {
                            Text(workout.name)
                                .foregroundColor(.primary)
                        } else {
                            Text("No workout")
                                .foregroundColor(.secondary)
                        }

                        Spacer()

                        Button("Edit") {
                            selectedDay = day
                            showWorkoutPicker = true
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
            }

            // Generator Buttons
            Section {
                Button("Set Workout Frequency") {
                    showFrequencySetup = true
                }
                .foregroundColor(.purple)

                Button("Auto Generate Week") {
                    generateSmartSchedule()
                }
                .foregroundColor(.blue)
            }
        }
        .navigationTitle("Schedule")
        .sheet(isPresented: $showWorkoutPicker) {
            WorkoutPickerView { workout in
                schedule[selectedDay] = workout
                showWorkoutPicker = false
            }
        }
        .sheet(isPresented: $showFrequencySetup) {
            WorkoutFrequencyView(
                legDays: $legDays,
                pushDays: $pushDays,
                pullDays: $pullDays,
                cardioDays: $cardioDays,
                restDays: $restDays
            )
        }
    }

    func generateSmartSchedule() {
        var pool: [String] = []
        pool += Array(repeating: "Leg", count: legDays)
        pool += Array(repeating: "Push", count: pushDays)
        pool += Array(repeating: "Pull", count: pullDays)
        pool += Array(repeating: "Cardio", count: cardioDays)
        pool += Array(repeating: "Rest", count: restDays)

        var spacedSchedule: [String] = []
        var usedTypes: [String] = []

        while !pool.isEmpty && spacedSchedule.count < daysOfWeek.count {
            // Find next workout that’s not the same as previous day
            if let next = pool.first(where: { $0 != usedTypes.last }) {
                spacedSchedule.append(next)
                usedTypes.append(next)

                // remove first matching from pool
                if let index = pool.firstIndex(of: next) {
                    pool.remove(at: index)
                }
            } else {
                // fallback: nothing unique left, just assign
                spacedSchedule.append(pool.removeFirst())
            }
        }

        for (index, day) in daysOfWeek.enumerated() {
            let name = index < spacedSchedule.count ? spacedSchedule[index] : "Rest"
            if let match = allWorkouts.first(where: { $0.name.localizedCaseInsensitiveContains(name) }) {
                schedule[day] = match
            } else {
                schedule[day] = Workout(name: name, date: .now, bio: "")
            }
        }
    }

}
