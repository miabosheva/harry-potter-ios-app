import Foundation

enum TabType: String {
    case books = "Books"
    case characters = "Characters"
    case settings = "Settings"
}

class HomeViewModel: ObservableObject {
    @Published var selectedTab: TabType = .books
}
