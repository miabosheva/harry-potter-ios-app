import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    @EnvironmentObject var localizableManager: LocalizableManager
    
    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            BookListView()
                .tabItem {
                    Label("Books".localized(), systemImage: "book.closed.fill")
                }
                .tag(TabType.books)
            
            CharacterListView()
                .tabItem {
                    Label("Characters".localized(), systemImage: "person.fill")
                }
                .tag(TabType.characters)
            
            SettingsView()
                .tabItem {
                    Label("Settings".localized(), systemImage: "gearshape.fill")
                }
                .tag(TabType.settings)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(LocalizableManager.shared)
}
