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
                
                if viewModel.isLoading && !viewModel.books.isEmpty {
                    LoadingView()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .listRowSeparator(.hidden)
                } else if (viewModel.books.isEmpty && !viewModel.isLoading) && (viewModel.errorMessage == nil || !viewModel.searchText.isEmpty) {
                    // placeholder for empty content
                    ContentUnavailableView(
                        "No Books Found",
                        systemImage: "book.closed"
                    )
                    .listRowSeparator(.hidden)
                    .frame(height: 350)
                }
            }
            .navigationTitle("tab_books".localized())
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
            .onAppear {
                print(UserDefaults.standard.array(forKey: "AppleLanguages"))
            }
        }
    }
}

#Preview {
    BookListView()
}
