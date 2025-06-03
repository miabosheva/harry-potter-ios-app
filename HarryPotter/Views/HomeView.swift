import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            BookListView()
                .tabItem {
                    Label("Books", systemImage: "book.closed.fill")
                }
                .tag(TabType.books)
            
            CharacterListView()
                .tabItem {
                    Label("Characters", systemImage: "person.fill")
                }
                .tag(TabType.characters)
        }
    }
}

#Preview {
    HomeView()
}
