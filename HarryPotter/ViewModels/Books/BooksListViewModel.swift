import Foundation
import Combine

class BooksListViewModel: ObservableObject {
    @Published var books: [Book] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var searchText: String = "" {
        didSet {
            searchCancellable?.cancel()
            searchCancellable = $searchText
                .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
                .sink(receiveValue: { [weak self] newText in
                    self?.currentPage = 1
                    self?.books = []
                    Task { @MainActor in
                        await self?.loadBooks(isSearching: true)
                    }
                })
        }
    }
    
    private let apiService: APIServiceProtocol
    private var currentPage = 1
    private let pageSize = 5
    private var canLoadMorePages = true
    private var searchCancellable: AnyCancellable?
    
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
            if isSearching && !searchText.isEmpty {
                fetchedBooks = try await apiService.fetchBooks(page: currentPage, max: pageSize, searchText: self.searchText)
            } else {
                fetchedBooks = try await apiService.fetchBooks(page: currentPage, max: pageSize, searchText: nil)
            }
            
            canLoadMorePages = fetchedBooks.count == pageSize
            
            if currentPage == 1 {
                self.books = fetchedBooks
            } else {
                self.books.append(contentsOf: fetchedBooks)
                print("\(fetchedBooks.count) added.")
            }
            
            isLoading = false
        } catch let error as APIError {
            errorMessage = error.errorDescription
            print(error.errorDescription)
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
    
    @MainActor
    func loadMoreBooks(currentBook: Book) async {
        guard canLoadMorePages, !isLoading else { return }
        guard let lastBook = books.last, lastBook.id == currentBook.id else { return }
        print("fetching more")
        currentPage += 1
        await loadBooks()
    }
    
    func reset() {
        self.books = []
        self.currentPage = 1
        self.canLoadMorePages = true
    }
}
