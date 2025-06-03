import SwiftUI

struct CharacterRowView: View {
    
    var character: Character
    
    var body: some View {
        HStack(alignment: .center) {
            
            Circle()
                .fill(Color.gray.opacity(0.5))
                .frame(maxWidth: 100, maxHeight: 100)
                .overlay {
                    KFImageView(imageUrl: character.image)
                        .frame(maxWidth: 95, maxHeight: 95)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(100)
                }
            
            VStack(alignment: .leading) {
                Text(character.fullName)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .font(.headline)
                Text(character.hogwartsHouse)
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                Text(character.birthdate)
                    .multilineTextAlignment(.leading)
                    .font(.caption)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 120)
//        .background(.red)
    }
}

#Preview {
    CharacterRowView(character: Character(fullName: "Harry Potter Poterovski", nickname: "Harry", hogwartsHouse: "Gryffindor", interpretedBy: "Radcliffe", children: [], image: "https://raw.githubusercontent.com/fedeperin/potterapi/main/public/images/characters/james_potter.png", birthdate: "17 June", index: 3))
}
