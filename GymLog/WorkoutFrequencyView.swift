import SwiftUI

struct WorkoutFrequencyView: View {
    @Binding var legDays: Int
    @Binding var pushDays: Int
    @Binding var pullDays: Int
    @Binding var cardioDays: Int
    @Binding var restDays: Int

    private var totalDays: Int {
        legDays + pushDays + pullDays + cardioDays + restDays
    }

    private let maxDays = 7

    var body: some View {
        Form {
            Section(header: Text("Select how many times per week")) {
                Stepper("Leg Days: \(legDays)", value: $legDays, in: 0...(maxDays - usedExcluding(legDays)))
                Stepper("Push Days: \(pushDays)", value: $pushDays, in: 0...(maxDays - usedExcluding(pushDays)))
                Stepper("Pull Days: \(pullDays)", value: $pullDays, in: 0...(maxDays - usedExcluding(pullDays)))
                Stepper("Cardio Days: \(cardioDays)", value: $cardioDays, in: 0...(maxDays - usedExcluding(cardioDays)))
                Stepper("Rest Days: \(restDays)", value: $restDays, in: 0...(maxDays - usedExcluding(restDays)))
            }

            if totalDays > maxDays {
                Text("⚠️ Too many days selected! Must total 7 or less.")
                    .foregroundColor(.red)
                    .font(.caption)
            } else {
                Text("Total: \(totalDays)/\(maxDays) days")
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle("Plan My Week")
    }

    private func usedExcluding(_ category: Int) -> Int {
        totalDays - category
    }
}
