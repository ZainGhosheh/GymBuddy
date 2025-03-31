import SwiftUI

struct WelcomeView: View {
    @AppStorage("userName") private var userName: String = ""
    @State private var inputName: String = ""
    @State private var isSignedIn = false
    @FocusState private var nameFocused: Bool

    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            VStack(spacing: 12) {
                Text("🏋️‍♂️ GymLog")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundColor(.blue)

                Text("Welcome\(userName.isEmpty ? "" : ", \(userName)")!")
                    .font(.title2)
                    .fontWeight(.semibold)
            }

            if !isSignedIn && userName.isEmpty {
                VStack(spacing: 16) {
                    TextField("Enter your name", text: $inputName)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal, 32)
                        .focused($nameFocused)

                    Button(action: {
                        withAnimation {
                            userName = inputName.trimmingCharacters(in: .whitespacesAndNewlines)
                            isSignedIn = true
                            nameFocused = false
                        }
                    }) {
                        Text("Let’s Go")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(12)
                            .padding(.horizontal, 32)
                    }
                    .disabled(inputName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            } else {
                NavigationLink(destination: LandingView()) {
                    Text("Continue to Gym")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(12)
                        .padding(.horizontal, 32)
                }
            }

            Spacer()
        }
        .padding()
        .onAppear {
            inputName = userName
        }
    }
}
