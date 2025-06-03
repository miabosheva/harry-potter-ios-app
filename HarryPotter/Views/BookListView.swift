import SwiftUI

struct BookListView: View {
    
    @StateObject private var viewModel = BooksListViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.books) {
                    book in
                    NavigationLink(value: book) {
                        BookRowView(book: book)
                    }
                }
            }
            .navigationDestination(for: Book.self) { book in
                BookDetailView(bookIndex: book.index)
            }
        }
    }
}

#Preview {
    BookListView()
}
