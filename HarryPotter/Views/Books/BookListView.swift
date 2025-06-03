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
                
                if viewModel.books.isEmpty && !viewModel.isLoading && viewModel.errorMessage == nil {
                    // placeholder for empty content
                    // TODO: - Change description, fix size
                    ContentUnavailableView(
                        "No Books Found",
                        systemImage: "book.closed",
                        description: Text("Lorem ipsum")
                    )
                    .listRowSeparator(.hidden)
                }
            }
            .navigationTitle("Books")
            .navigationDestination(for: Book.self) { book in
                BookDetailView(bookIndex: book.index)
                    .navigationTitle(book.title)
                    .navigationBarTitleDisplayMode(.inline)
            }
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
