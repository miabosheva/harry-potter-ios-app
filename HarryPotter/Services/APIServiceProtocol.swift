import Foundation

protocol APIServiceProtocol {
    func fetchBooks() async throws -> [Book]
    func fetchBook(bookIndex: Int) async throws -> Book
    func fetchCharacters() async throws -> [Character]
    func fetchCharacter(characterIndex: Int) async throws -> Character
}
