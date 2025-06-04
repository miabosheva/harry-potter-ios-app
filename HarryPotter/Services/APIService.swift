import Foundation

class APIService: APIServiceProtocol {
    
    private var baseURL = "https://potterapi-fedeperin.vercel.app/en"
    
    func fetchBooks(page: Int?, max: Int?, searchText: String?) async throws -> [Book] {
        guard var urlComponents = URLComponents(string: baseURL + "/books") else {
            throw APIError.invalidURL
        }
        
        // add the query params if there are any
        var queryParams: [String: String] = [:]
        if let max = max {
            queryParams["max"] = String(max)
            if let page = page {
                queryParams["page"] = String(page)
            }
        }
        
        // add search query param if there is one
        if let searchText = searchText {
            queryParams["search"] = searchText
        }
        
        if !queryParams.isEmpty {
            urlComponents.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = urlComponents.url else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            if httpResponse.statusCode == 404 {
                print("API returned 404. Treating it as an empty result.")
                return []
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw APIError.serverError(statusCode: httpResponse.statusCode, data: data)
            }
            
            let decoder = JSONDecoder()
            
            return try decoder.decode([Book].self, from: data)
            
        } catch let decodingError as DecodingError {
            throw APIError.decodingError(decodingError)
        } catch let urlError as URLError {
            throw APIError.networkError(urlError)
        } catch let apiError as APIError {
            throw apiError
        } catch {
            throw APIError.unknown
        }
    }
    
    func fetchBook(bookIndex: Int) async throws -> Book {
        guard var urlComponents = URLComponents(string: baseURL + "/books") else {
            throw APIError.invalidURL
        }
        
        urlComponents.queryItems = [URLQueryItem(name: "index", value: String(bookIndex))]
        
        guard let url = urlComponents.url else {
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
            
            return try decoder.decode(Book.self, from: data)
            
        } catch let decodingError as DecodingError {
            throw APIError.decodingError(decodingError)
        } catch let urlError as URLError {
            throw APIError.networkError(urlError)
        } catch let apiError as APIError {
            throw apiError
        } catch {
            throw APIError.unknown
        }
    }
    
    func fetchCharacters(page: Int?, max: Int?) async throws -> [Character] {
        
        guard var urlComponents = URLComponents(string: baseURL + "/characters") else {
            throw APIError.invalidURL
        }
        
        // add the query params if there are any
        var queryParams: [String: String] = [:]
        if let max = max {
            queryParams["max"] = String(max)
            if let page = page {
                queryParams["page"] = String(page)
            }
        }
        if !queryParams.isEmpty {
            urlComponents.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = urlComponents.url else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            if httpResponse.statusCode == 404 {
                print("API returned 404. Treating it as an empty result.")
                return []
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw APIError.serverError(statusCode: httpResponse.statusCode, data: data)
            }
            
            let decoder = JSONDecoder()
            
            return try decoder.decode([Character].self, from: data)
            
        } catch let decodingError as DecodingError {
            throw APIError.decodingError(decodingError)
        } catch let urlError as URLError {
            throw APIError.networkError(urlError)
        } catch let apiError as APIError {
            throw apiError
        } catch {
            throw APIError.unknown
        }
    }
    
    func fetchCharacter(characterIndex: Int) async throws -> Character {
        guard var urlComponents = URLComponents(string: baseURL + "/characters") else {
            throw APIError.invalidURL
        }
        
        urlComponents.queryItems = [URLQueryItem(name: "index", value: String(characterIndex))]
        
        guard let url = urlComponents.url else {
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
            
            return try decoder.decode(Character.self, from: data)
            
        } catch let decodingError as DecodingError {
            throw APIError.decodingError(decodingError)
        } catch let urlError as URLError {
            throw APIError.networkError(urlError)
        } catch let apiError as APIError {
            throw apiError
        } catch {
            throw APIError.unknown
        }
    }
}
