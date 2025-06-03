import Foundation

protocol APIServiceProtocol {
    func fetchBooks(page: Int) async throws -> [Book]
}
