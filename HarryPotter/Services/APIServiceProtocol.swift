import Foundation

protocol APIServiceProtocol {
    func fetchBooks() async throws -> [Book]
    func fetchBook(index: Int) async throws -> Book
}
