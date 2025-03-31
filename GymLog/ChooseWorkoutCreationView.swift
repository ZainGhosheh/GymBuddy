import SwiftUI

struct ChooseWorkoutCreationView: View {
    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            Text("How do you want to build this workout?")
                .font(.title2)
                .multilineTextAlignment(.center)

            NavigationLink("📝 Create Workout Manually", destination: AddWorkoutView())
                .buttonStyle(.borderedProminent)

            NavigationLink("🌐 Generate Workout with AI", destination: APIGeneratedWorkoutView())
                .buttonStyle(.bordered)

            Spacer()
        }
        .padding()
        .navigationTitle("New Workout")
    }
}
