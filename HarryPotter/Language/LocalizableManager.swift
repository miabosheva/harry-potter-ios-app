import Foundation
import SwiftUI

enum AppLanguage: String, CaseIterable, Identifiable, RawRepresentable {
    case en = "en"
    case es = "es"
    var id: String { self.rawValue }
    
    var displayName: String {
        switch self {
        case .en: return "English"
        case .es: return "Español"
        }
    }
}

class LocalizableManager: ObservableObject {
    static let shared = LocalizableManager()

    private let preferredLanguageKey = "preferredAppLanguage"

    @Published var currentAppLanguage: AppLanguage {
        didSet {
            UserDefaults.standard.set(currentAppLanguage.rawValue, forKey: preferredLanguageKey)
            UserDefaults.standard.set([currentAppLanguage.rawValue], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()

            print("Language changed to: \(currentAppLanguage.rawValue)")
        }
    }

    private init() {
        if let savedLangCode = UserDefaults.standard.string(forKey: preferredLanguageKey),
           let savedAppLang = AppLanguage(rawValue: savedLangCode) {
            _currentAppLanguage = Published(initialValue: savedAppLang)
        } else if let systemPreferredLangCode = Locale.current.language.languageCode?.identifier,
                  let systemPreferredAppLang = AppLanguage(rawValue: systemPreferredLangCode) {
            _currentAppLanguage = Published(initialValue: systemPreferredAppLang)
        } else {
            _currentAppLanguage = Published(initialValue: .en)
        }

        UserDefaults.standard.set([currentAppLanguage.rawValue], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
}

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
