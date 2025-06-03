import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(.circular)
            .scaleEffect(1.5)
            .padding()
    }
}

#Preview {
    LoadingView()
}
