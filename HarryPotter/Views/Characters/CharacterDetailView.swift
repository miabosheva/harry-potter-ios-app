import SwiftUI

struct CharacterDetailView: View {
    
    var characterIndex: Int
    @StateObject private var viewModel: CharacterDetailViewModel
    
    init(characterIndex: Int) {
        _viewModel = StateObject(wrappedValue: CharacterDetailViewModel(characterIndex: characterIndex))
        self.characterIndex = characterIndex
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                LoadingView()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 50)
            } else if let character = viewModel.character {
                KFImageView(imageUrl: character.image)
                Text(character.fullName)
            }
        }
    }
}

#Preview {
    CharacterDetailView(characterIndex: 2)
}
