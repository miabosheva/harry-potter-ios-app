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
                            .onAppear {
                                Task { @MainActor in
                                    await viewModel.loadMoreBooks(currentBook: book)
                                }
                            }
                    }
                }
                
                // when books are empty in list and in search
                if (viewModel.books.isEmpty && !viewModel.isLoading) && (viewModel.errorMessage == nil || !viewModel.searchText.isEmpty) {
                    // placeholder for empty content
                    // TODO: - Change description, fix size
                    ContentUnavailableView(
                        "No Books Found",
                        systemImage: "book.closed"
                    )
                    .listRowSeparator(.hidden)
                    .frame(height: 350)
                }
            }
            .navigationTitle("Books")
            .navigationDestination(for: Book.self) { book in
                BookDetailView(bookIndex: book.index)
                    .navigationTitle(book.title)
                    .navigationBarTitleDisplayMode(.inline)
            }
            .searchable(text: $viewModel.searchText, prompt: "Search Books...")
            .refreshable {
                Task { @MainActor in
                    viewModel.reset()
                    await viewModel.loadBooks()
                }
            }
            .overlay {
                if viewModel.isLoading && viewModel.books.isEmpty {
                    LoadingView()
                } else if let error = viewModel.errorMessage {
                    ErrorMessageView(message: error) {
                        Task { @MainActor in
                            await viewModel.loadBooks()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    BookListView()
}
