import Foundation

class BookDetailViewModel: ObservableObject {
    @Published var book: Book?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let bookIndex: Int
    private let apiService: APIServiceProtocol
    
    init(bookIndex: Int, apiService: APIServiceProtocol = APIService()) {
        self.bookIndex = bookIndex
        self.apiService = apiService
        Task { @MainActor in
            await fetchBookDetails()
        }
    }
    
    @MainActor
    func fetchBookDetails() async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        
        do {
            self.book = try await apiService.fetchBook(index: bookIndex)
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
}
