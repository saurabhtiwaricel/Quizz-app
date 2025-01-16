import Foundation

struct UserData: Codable {
    let question: String
    let options: [String]
    let answer: String
}
