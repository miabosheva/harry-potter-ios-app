import Foundation

enum APIError : LocalizedError {
    case invalidURL
    case networkError(URLError)
    case decodingError(Error)
    case serverError(statusCode: Int, data: Data?)
    case invalidResponse
    case unknown 

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("The API URL was invalid. Please contact support.", comment: "Invalid URL error message")
        case .networkError(let urlError):
            return NSLocalizedString("A network connection error occurred: \(urlError.localizedDescription)", comment: "Network error message")
        case .decodingError(let decodingError):
            print("Decoding Error: \(decodingError)")
            return NSLocalizedString("Failed to process data from the server. Please try again later.", comment: "Decoding error message")
        case .serverError(let statusCode, _):
            if statusCode >= 500 {
                return NSLocalizedString("The server encountered an error. Please try again later.", comment: "Server error message")
            } else {
                return NSLocalizedString("An unexpected server error occurred (Status Code: \(statusCode)).", comment: "Generic server error message")
            }
        case .invalidResponse:
            return NSLocalizedString("Received an unexpected response from the server.", comment: "Invalid response type error")
        case .unknown:
            return NSLocalizedString("An unknown error occurred. Please try again.", comment: "Unknown error message")
        }
    }
}
