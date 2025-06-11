# Harry Potter App

A SwiftUI app to browse through Harry Potter books and characters. It features image caching, robust search, and multi-language support.

---

## How to Launch the App

### Prerequisites

* **Xcode:** Version 15.0 or later (recommended for iOS 17+ and visionOS development).
* **macOS:** Sonoma 14.0 or later.

### Steps to Run

1.  **Clone the Repository:**
    ```bash
    git clone https://github.com/miabosheva/harry-potter-ios-app.git
    cd harry-potter-ios-app
    ```
    
2.  **Open in Xcode:**
    ```bash
    open HarryPotter.xcodeproj
    ```
    
3.  **Resolve Swift Packages:**
    This project uses **Swift Package Manager (SPM)** for its dependencies, including **Kingfisher** for image handling. Xcode should automatically resolve them when you open the project. If not, go to `File` > `Packages` > `Resolve Package Versions`. If you encounter issues (like "RPC failed"), try `File` > `Packages` > `Reset Package Caches`, then `Product` > `Clean Build Folder`, and re-resolve packages.

4.  **Select a Target and Device/Simulator:**
    In the Xcode toolbar (next to the "Run" button), click the scheme dropdown:

    * **For iOS:** Select the `HarryPotter (iOS)` scheme and choose your desired iPhone simulator or a connected iOS device.
    * **For visionOS:** Select the `HarryPotter (visionOS)` scheme and choose the `visionOS Simulator`.

5.  **Run the App:**
    Click the "Run" button (▶️) in the Xcode toolbar, or go to `Product` > `Run`. Xcode will build the project and launch the app.

## App Functionalities

This app offers a range of features:

* **Tab-Based Navigation:** Navigate between the primary sections of the app: **Books**, **Characters**, and **Settings**.
* **List through Characters and Books Dynamically**
* **External API Integration** dynamically fetched from the **PotterAPI** (`https://potterapi-fedeperin.vercel.app/`, Documentation: `https://vlaurencena.github.io/harry-potter-openapi-swagger-ui/`).
* **Pagination:** Both book and character lists, including search results utilize **pagination** which optimizes performance.
* **Search Functionality:** Find specific books or characters using the integrated search bars within their respective sections.
* **Dynamic Language Switching:**
    * Users can seamlessly switch the app's display language between **English (en)** and **Spanish (es)** directly from the **Settings** tab.
    * Your preferred language choice is **persisted** using `UserDefaults`, so the app remembers your setting across launches.
    * Restart the app in order for all language changes to take full effect.
* **Loading screens and Error Handling:** The app includes **loading indicators** when data is being load and **error messages** when API calls fail or other issues occur.
* **Detail Views:** Tap on any book or character in the lists to access a dedicated detail view with more information.
* **visionOS Adaptation:** The app includes an initial configuration for visionOS, allowing it to run as a **floating `WindowGroup`** in a spatial computing environment. 
