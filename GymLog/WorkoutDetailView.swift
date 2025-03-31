import SwiftUI
import SwiftData

struct WorkoutDetailView: View {
    @Bindable var workout: Workout

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text(workout.name)
                        .font(.largeTitle)
                        .bold()

                    Spacer()

                    NavigationLink(destination: EditWorkoutView(workout: workout)) {
                        Text("Edit")
                            .font(.body)
                            .padding(8)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(8)
                    }
                }

                Text("Date: \(workout.date.formatted(date: .abbreviated, time: .shortened))")
                    .font(.subheadline)

                Text(workout.bio)
                    .font(.body)

                Divider()
                // Your exercises + sets UI here...
            }
            .padding()
        }
        .navigationTitle("Workout Details")
    }
}
