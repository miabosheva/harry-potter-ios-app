import Foundation

class CharacterDetailViewModel: ObservableObject {
    @Published var character: Character?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let characterIndex: Int
    private let apiService: APIServiceProtocol
    
    init(characterIndex: Int, apiService: APIServiceProtocol = APIService()) {
        self.characterIndex = characterIndex
        self.apiService = apiService
        Task { @MainActor in
            await fetchCharacterDetails()
        }
    }
    
    @MainActor
    func fetchCharacterDetails() async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        
        do {
            self.character = try await apiService.fetchCharacter(characterIndex: characterIndex)
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
}
