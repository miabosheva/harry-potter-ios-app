import Foundation

struct Book: Codable, Identifiable, Hashable {
    var number: Int
    var title: String
    var originalTitle: String
    var releaseDate: String
    var description: String
    var pages: Int
    var cover: String
    var index: Int
    var id: Int {
        return index
    }
}
