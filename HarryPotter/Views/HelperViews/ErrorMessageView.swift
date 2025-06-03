import SwiftUI

struct ErrorMessageView: View {
    let message: String
    let retryAction: (() -> Void)?

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.title)
                .foregroundColor(.red)

            Text("Error")
                .font(.headline)
                .foregroundColor(.red)

            Text(message)
                .padding(.vertical, 8)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)

            if let retryAction = retryAction {
                Button("Retry") {
                    retryAction()
                }
                .buttonStyle(.borderedProminent)
                .padding(.top, 8)
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(Color.red.opacity(0.1))
        .cornerRadius(10)
        .padding(.horizontal, 32)
    }
}

#Preview {
    ErrorMessageView(message: "Lorem ipsum dolor sit amet.") {}
}
