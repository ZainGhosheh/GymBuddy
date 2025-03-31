import SwiftUI

struct LandingView: View {
    @AppStorage("userName") private var userName: String = ""

    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            // Big welcome
            VStack(spacing: 10) {
                Text("Welcome Back, \(userName)!")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Today is \(Date.now.formatted(date: .long, time: .omitted))")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            // Divider for spacing
            Divider()
                .padding(.horizontal)

            // Buttons
            VStack(spacing: 20) {
                NavigationLink(destination: WorkoutListView()) {
                    Label("My Workouts", systemImage: "list.bullet.rectangle")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }

                NavigationLink(destination: SchedulePlannerView()) {
                    Label("View Schedule", systemImage: "calendar")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
        .navigationTitle("Dashboard")
    }
}
