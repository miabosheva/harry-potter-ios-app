import SwiftUI

@main
struct HarryPotterVisionOSApp: App {
    
    @StateObject private var localizableManager = LocalizableManager.shared
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(localizableManager)
        }
    }
}
