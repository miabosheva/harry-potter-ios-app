import SwiftUI

struct BookRowView: View {
    
    var book: Book
    
    var body: some View {
        HStack(alignment: .center) {
            
            KFImageView(imageUrl: book.cover)
                .frame(maxWidth: 100, maxHeight: 150)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(10)
                .padding(.leading, 8)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(book.title)
                    .multilineTextAlignment(.leading)
                    .font(.headline)
                Text(book.originalTitle)
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                Text(book.releaseDate)
                    .multilineTextAlignment(.leading)
                    .font(.caption)
            }
            .padding(16)
            
            Spacer()
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 182)
//        .background(.red)
    }
}

#Preview {
    BookRowView(book: Book(number: 2, title: "Some Title", originalTitle: "Original Title", releaseDate: "17 June", description: "Lorem ipsum dolor sit amet", pages: 23, cover: "https://raw.githubusercontent.com/fedeperin/potterapi/main/public/images/characters/james_potter.png", index: 7))
}
