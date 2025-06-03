import SwiftUI

struct CharacterRowView: View {
    
    var character: Character
    
    var body: some View {
        VStack {
            Text(character.nickname)
            Text(character.fullName)
        }
    }
}

#Preview {
    CharacterRowView(character: Character(fullName: "Harry Potter", nickname: "Harry", hogwartsHouse: "Gryffindor", interpretedBy: "Radcliffe", children: [], image: "", birthdate: "17 June", index: 3))
}
