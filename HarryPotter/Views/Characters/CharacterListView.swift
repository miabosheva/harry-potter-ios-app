import SwiftUI

struct CharacterListView: View {
    
    @StateObject private var viewModel = CharacterListViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.characters) {
                    character in
                    NavigationLink(value: character) {
                        CharacterRowView(character: character)
                            .onAppear {
                                Task { @MainActor in
                                    await viewModel.loadMoreCharacters(currentCharacter: character)
                                }
                            }
                    }
                }
                
                if viewModel.isLoading && !viewModel.characters.isEmpty {
                    LoadingView()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .listRowSeparator(.hidden)
                } else if viewModel.characters.isEmpty && !viewModel.isLoading && viewModel.errorMessage == nil {
                    // placeholder for empty content
                    // TODO: - Change description, fix size
                    ContentUnavailableView(
                        "No Characters Found",
                        systemImage: "person.fill",
                        description: Text("Lorem ipsum")
                    )
                    .listRowSeparator(.hidden)
                }
            }
            .navigationTitle("Characters")
            .navigationDestination(for: Character.self) { character in
                CharacterDetailView(characterIndex: character.index)
                    .navigationTitle(character.nickname)
                    .navigationBarTitleDisplayMode(.inline)
            }
            .refreshable {
                Task { @MainActor in
                    viewModel.reset()
                    await viewModel.loadCharacters()
                }
            }
            .overlay {
                if viewModel.isLoading && viewModel.characters.isEmpty {
                    LoadingView()
                } else if let error = viewModel.errorMessage {
                    ErrorMessageView(message: error) {
                        Task { @MainActor in
                            await viewModel.loadCharacters()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CharacterListView()
}
