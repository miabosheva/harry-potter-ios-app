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
                ZStack {
                    // Image background
                    VStack {
                        KFImageView(imageUrl: book.cover, aspectRatio: .fit)
                            .ignoresSafeArea()
                            .frame(maxWidth: .infinity)
                            .overlay {
                                Color.clear.background(.ultraThinMaterial)
                            }
                        Spacer()
                    }
                    
                    ScrollView {
                        KFImageView(imageUrl: book.cover)
                            .frame(maxWidth: 150, maxHeight: 230)
                            .background(Color.gray.opacity(0.5))
                            .cornerRadius(10)
                            .zIndex(10)
                            .offset(y: 75)
                            .shadow(radius: 8)
                        
                        VStack(alignment: .center) {
                            
                            VStack {
                                Text(book.title)
                                    .font(.title2)
                                    .multilineTextAlignment(.center)
                                    .bold()
                                    .padding(.bottom, 4)
                                
                                Text(book.releaseDate)
                                    .fontWeight(.light)
                            }
                            .padding(.bottom, 16)
                            
                            VStack(alignment: .leading, spacing: 16) {
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("PAGES")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    Text("\(book.pages)")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                }
                                
                                Divider()
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("ORIGINAL TITLE")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    Text(book.originalTitle)
                                        .font(.body)
                                }
                                
                                Divider()
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("DESCRIPTION")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                        .padding(.bottom, 4)
                                    
                                    Text(book.description)
                                }
                            }
                            .padding(.horizontal, 4)
                            .padding(.vertical, 8)
                        }
                        .padding(.top, 90)
                        // added some more on the bottom for visibility
                        .padding(.bottom, 16)
                        .padding(.horizontal, 16)
                        .background(UnevenRoundedRectangle(cornerRadii: .init(topLeading: 20, topTrailing: 20))
                            .fill(Color.white))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
            }
        }
    }
}

#Preview {
    BookDetailView(bookIndex: 1)
}
