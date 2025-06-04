import Foundation
import SwiftUI

class APIService: APIServiceProtocol {
    
    private let localizableManager = LocalizableManager.shared
    
    private var baseURL: String {
        let languageCode = localizableManager.currentAppLanguage.rawValue
        return "https://potterapi-fedeperin.vercel.app/\(languageCode)"
    }
    
    // MARK: - Book Methods
    
    /// Fetch Books:
    /// params:
    ///  - page: Int?
    ///  - max: Int? - number of results per page
    ///  - searchText: String? - used when searching
    ///
    ///  returns a list of Book structs
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
            
            // Trying to paginate the search results. API returns 404 if the search results are empty but we try to access the first page.
            if httpResponse.statusCode == 404 && searchText != nil {
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
    
    /// Fetch a Book:
    /// params:
    ///  - bookIndex: Int - the index of a individual book
    ///
    ///  returns a Book object
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
    
    // MARK: - Character Methods
    
    /// Fetch Characters:
    /// params:
    ///  - page: Int?
    ///  - max: Int? - number of results per page
    ///  - searchText: String? - used when searching
    ///
    ///  returns a list of Character structs
    func fetchCharacters(page: Int?, max: Int?, searchText: String?) async throws -> [Character] {
        
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
            
            // Trying to paginate the search results. API returns 404 if the search results are empty but we try to access the first page.
            if httpResponse.statusCode == 404 && searchText != nil {
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
    
    /// Fetch a Character:
    /// params:
    ///  - bookIndex: Int - the index of a individual character
    ///
    ///  returns a Character object
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
