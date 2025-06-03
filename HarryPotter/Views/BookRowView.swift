import SwiftUI

struct BookRowView: View {
    
    var book: Book
    
    var body: some View {
        VStack {
            Text(book.title)
            Text(book.originalTitle)
        }
    }
}

#Preview {
    BookRowView(book: Book(number: 2, title: "Some Title", originalTitle: "Original Title", releaseDate: "17 June", description: "Lorem ipsum dolor sit amet", pages: 23, cover: "", index: 7))
}
