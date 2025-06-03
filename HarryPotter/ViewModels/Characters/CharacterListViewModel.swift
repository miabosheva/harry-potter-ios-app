import Foundation

class CharacterListViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let apiService: APIServiceProtocol
    
    private var currentPage = 1
    private let pageSize = 10
    private var canLoadMorePages = true
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
        
        Task { @MainActor in
            await loadCharacters()
        }
    }
    
    @MainActor
    func loadCharacters() async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        
        do {
            let fetchedCharacters: [Character]
            fetchedCharacters = try await apiService.fetchCharacters(page: currentPage, max: pageSize)
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
