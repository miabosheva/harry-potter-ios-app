import Foundation

class APIService: APIServiceProtocol {
    
    private var baseURL = "https://potterapi-fedeperin.vercel.app/en"
    
    func fetchBooks(page: Int) async throws -> [Book] {
        guard let url = URL(string: baseURL + "/books") else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw APIError.serverError(statusCode: httpResponse.statusCode, data: data)
            }
            
            let decoder = JSONDecoder()
            
            return try decoder.decode([Book].self, from: data)
        }
    }
}
