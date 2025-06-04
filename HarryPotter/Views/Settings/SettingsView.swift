import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var localizableManager: LocalizableManager
    @State private var showingRestartAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Select Language", selection: $localizableManager.currentAppLanguage) {
                    ForEach(AppLanguage.allCases) { language in
                        HStack {
                            Text(language.displayName)
                            Spacer()
                        }
                        .contentShape(Rectangle())
                        .tag(language)
                    }
                }
                .pickerStyle(.inline)
                
                Section {
                    Button(action: {
                        showingRestartAlert = true
                    }) {
                        HStack {
                            Image(systemName: "arrow.counterclockwise.circle.fill")
                            Text("Restart App")
                        }
                        .foregroundColor(.red)
                    }
                    
                    Text("Changes to language require an app restart.")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("Settings")
            .alert("Restart App?", isPresented: $showingRestartAlert) {
                Button("Restart", role: .destructive) {
                    exit(0)
                }
                
                Button("Cancel", role: .cancel) {
                }
            } message: {
                Text("Changes to language may require an app restart to take full effect.")
            }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(LocalizableManager.shared)
}
