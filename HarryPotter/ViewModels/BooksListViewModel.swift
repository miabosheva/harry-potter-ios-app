import Foundation

class BooksListViewModel: ObservableObject {
    @Published var books: [Book] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let apiService: APIServiceProtocol
    
    private var currentPage = 1
    private let pageSize = 223
    private var canLoadMorePages = true
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
        
        Task { @MainActor in
            await loadBooks()
        }
    }
    
    @MainActor
    func loadBooks(isSearching: Bool = false) async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil

        do {
            let fetchedBooks: [Book]
           
            fetchedBooks = try await apiService.fetchBooks(page: currentPage)
            canLoadMorePages = fetchedBooks.count == pageSize

            if currentPage == 1 {
                self.books = fetchedBooks
            } else {
                self.books.append(contentsOf: fetchedBooks)
            }

            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
}
