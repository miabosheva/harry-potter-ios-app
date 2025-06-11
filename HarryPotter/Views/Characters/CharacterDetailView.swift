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
                
                ZStack {
                    // Image background
                    GeometryReader { geometry in
                        KFImageView(imageUrl: character.image, aspectRatio: .fill)
                        //                            .ignoresSafeArea()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                            .ignoresSafeArea()
                            .overlay {
                                Color.clear.background(.ultraThinMaterial)
                            }
                        Spacer()
                    }
                    
                    ScrollView {
                        Circle()
                            .fill(Color.gray.opacity(0.5))
                            .frame(maxWidth: 150, maxHeight: 150)
                            .overlay {
                                KFImageView(imageUrl: character.image)
                                    .frame(maxWidth: 140, maxHeight: 140)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(100)
                            }
                            .zIndex(10)
                            .offset(y: 75)
                        
                        VStack(alignment: .center) {
                            VStack {
                                Text(character.fullName)
                                    .font(.title)
                                    .bold()
                                
                                Text(character.nickname)
                                    .fontWeight(.light)
                            }
                            .padding(.bottom, 16)
                            
                            HousesCardView(house: House.init(rawValue: character.hogwartsHouse) ?? House.noHouse)
                            
                            VStack(alignment: .leading, spacing: 16) {
                                if !character.interpretedBy.isEmpty {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("INTERPRETED BY")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                        Text(character.interpretedBy)
                                            .font(.body)
                                            .fontWeight(.semibold)
                                    }
                                }
                                
                                Divider()
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("BIRTH DATE")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    Text(character.birthdate)
                                        .font(.body)
                                        .fontWeight(.semibold)
                                }
                                
                                if let children = character.children, !children.isEmpty {
                                    Divider()
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("CHILDREN")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                            .padding(.bottom, 4)
                                        
                                        ForEach(children, id: \.self) { child in
                                            Text(child)
                                                .font(.body)
                                                .fontWeight(.semibold)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 4)
                            .padding(.vertical, 8)
                        }
                        .padding(.top, 90)
                        // added some more on the bottom for visibility
                        .padding(.bottom, 64)
                        .padding(.horizontal, 16)
                        .background(UnevenRoundedRectangle(cornerRadii: .init(topLeading: 20, topTrailing: 20))
                            .fill(Color(.systemBackground)))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
    }
}

#Preview {
    CharacterDetailView(characterIndex: 2)
}
