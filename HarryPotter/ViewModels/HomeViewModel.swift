import Foundation

enum TabType: String {
    case books = "Books"
    case characters = "Characters"
}

class HomeViewModel: ObservableObject {
    @Published var selectedTab: TabType = .books
}
