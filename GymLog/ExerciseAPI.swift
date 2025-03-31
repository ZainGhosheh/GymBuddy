import Foundation

// Fetches exercises for a specific muscle group (Wger API)
func fetchExercises(for muscleId: Int, completion: @escaping ([Exercise]) -> Void) {
    guard let url = URL(string: "https://wger.de/api/v2/exercise/?language=2&muscles=\(muscleId)") else {
        print("❌ Invalid URL")
        completion([])
        return
    }

    URLSession.shared.dataTask(with: url) { data, _, error in
        guard let data = data else {
            print("❌ Error: \(error?.localizedDescription ?? "Unknown error")")
            completion([])
            return
        }

        do {
            let decoded = try JSONDecoder().decode(ExerciseResponse.self, from: data)
            DispatchQueue.main.async {
                completion(decoded.results)
            }
        } catch {
            print("❌ Decoding failed: \(error)")
            completion([])
        }
    }.resume()
}
