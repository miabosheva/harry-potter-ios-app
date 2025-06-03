import Foundation

struct Character: Codable, Identifiable, Hashable {
    var fullName: String
    var nickname: String
    var hogwartsHouse: String
    var interpretedBy: String
    var children: [String]?
    var image: String
    var birthdate: String
    var index: Int
    var id: Int {
        return index
    }
}
