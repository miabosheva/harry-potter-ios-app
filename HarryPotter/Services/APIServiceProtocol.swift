import Foundation

protocol APIServiceProtocol {
    func fetchBooks(page: Int?, max: Int?) async throws -> [Book]
    func fetchBook(bookIndex: Int) async throws -> Book
    func fetchCharacters(page: Int?, max: Int?) async throws -> [Character]
    func fetchCharacter(characterIndex: Int) async throws -> Character
}
