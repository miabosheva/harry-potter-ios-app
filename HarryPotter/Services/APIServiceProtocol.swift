import Foundation

protocol APIServiceProtocol {
    func fetchBooks(page: Int?, max: Int?, searchText: String?) async throws -> [Book]
    func fetchBook(bookIndex: Int) async throws -> Book
    func fetchCharacters(page: Int?, max: Int?, searchText: String?) async throws -> [Character]
    func fetchCharacter(characterIndex: Int) async throws -> Character
}
