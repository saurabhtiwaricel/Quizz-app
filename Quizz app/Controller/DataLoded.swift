import Foundation
import Combine

public class DataLoader: ObservableObject {
    
    @Published var userData = [UserData]()
    private var availableQuestions: [UserData] = []
    
    init() {
        load()
        resetQuestions()
    }
    
    func load() {
        if let fileLocation = Bundle.main.url(forResource: "quiz", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([UserData].self, from: data)
                self.userData = dataFromJson
                resetQuestions()
            } catch {
                print(error)
            }
        } else {
            print("File not found")
        }
    }
    
    // Resets the list of available questions
    func resetQuestions() {
        availableQuestions = userData.shuffled()
    }
    
    // Fetches random questions without repetition
    func randomQuestions(count: Int) -> [UserData] {
        guard count > 0 else { return [] }
        var selectedQuestions: [UserData] = []
        
        for _ in 0..<count {
            if let question = availableQuestions.first {
                selectedQuestions.append(question)
                availableQuestions.removeFirst()
            } else {
                // If we've exhausted all questions, reset the list
                resetQuestions()
            }
        }
        return selectedQuestions
    }
}
