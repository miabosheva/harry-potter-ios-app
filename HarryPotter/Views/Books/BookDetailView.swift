import SwiftUI

struct BookDetailView: View {
    
    var bookIndex: Int
    @StateObject private var viewModel: BookDetailViewModel
    
    init(bookIndex: Int) {
        _viewModel = StateObject(wrappedValue: BookDetailViewModel(bookIndex: bookIndex))
        self.bookIndex = bookIndex
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                LoadingView()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 50)
            } else if let book = viewModel.book {
                Text(book.originalTitle)
            }
        }
//        .navigationTitle(viewModel.book?.title ?? "")
//        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    BookDetailView(bookIndex: 1)
}
