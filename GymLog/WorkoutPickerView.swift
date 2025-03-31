import SwiftUI
import SwiftData

struct WorkoutPickerView: View {
    @Query private var allWorkouts: [Workout]
    var onSelect: (Workout) -> Void

    var body: some View {
        NavigationStack {
            List {
                ForEach(allWorkouts) { workout in
                    Button {
                        onSelect(workout)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(workout.name)
                                .font(.headline)
                            if !workout.bio.isEmpty {
                                Text(workout.bio)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Choose Workout")
        }
    }
}
