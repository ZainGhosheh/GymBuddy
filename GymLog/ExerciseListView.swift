import SwiftUI

struct ExerciseListView: View {
    @State private var exercises: [Exercise] = []

    var body: some View {
        List(exercises) { exercise in
            VStack(alignment: .leading) {
                Text(exercise.name)
                    .font(.headline)

                if !exercise.description.isEmpty {
                    Text(exercise.description)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding(.vertical, 4)
        }
        .onAppear {
            fetchExercises(for: 10) { result in // 10 = Legs
                exercises = result
            }
        }
        .navigationTitle("Leg Exercises")
    }
}
