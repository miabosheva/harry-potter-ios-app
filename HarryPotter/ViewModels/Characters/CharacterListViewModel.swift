import Foundation
import Combine

class CharacterListViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var searchText: String = "" {
        didSet {
            searchCancellable?.cancel()
            searchCancellable = $searchText
                .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
                .sink(receiveValue: { [weak self] newText in
                    self?.currentPage = 1
                    self?.characters = []
                    Task { @MainActor in
                        await self?.loadCharacters(isSearching: true)
                    }
                })
        }
    }
    
    private let apiService: APIServiceProtocol
    private var currentPage = 1
    private let pageSize = 10
    private var canLoadMorePages = true
    private var searchCancellable: AnyCancellable?
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
        
        Task { @MainActor in
            await loadCharacters()
        }
    }
    
    @MainActor
    func loadCharacters(isSearching: Bool = false) async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        
        do {
            let fetchedCharacters: [Character]
            
            if isSearching && !searchText.isEmpty {
                // paginate search results
                fetchedCharacters = try await apiService.fetchCharacters(page: currentPage, max: pageSize, searchText: self.searchText)
            } else {
                fetchedCharacters = try await apiService.fetchCharacters(page: currentPage, max: pageSize, searchText: nil)
            }
            
            canLoadMorePages = fetchedCharacters.count == pageSize

            if currentPage == 1 {
                self.characters = fetchedCharacters
            } else {
                self.characters.append(contentsOf: fetchedCharacters)
            }
            
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
    
    /// MARK: - Method for pagination. Called when view reaches last row.
    @MainActor
    func loadMoreCharacters(currentCharacter: Character) async {
        guard canLoadMorePages, !isLoading else { return }
        guard let lastCharacter = characters.last, lastCharacter.id == currentCharacter.id else { return }
        
        currentPage += 1
        await loadCharacters()
    }
    
    func reset() {
        self.characters = []
        self.currentPage = 1
        self.canLoadMorePages = true
    }
}
