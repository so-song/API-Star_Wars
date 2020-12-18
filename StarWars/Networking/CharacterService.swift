//
//  CharacterService.swift
//  StarWars
//
//  Created by Sophie SONG on 18/12/2020.
//

import Foundation

//
// MARK: - Character Service
//

/// Runs query data task, and stores results in array of Tracks
class CharacterService {
    //
    // MARK: - Constants
    //
    let defaultSession = URLSession(configuration: .default)
    
    //
    // MARK: - Variables And Properties
    //
    var dataTask: URLSessionDataTask?
    
    /// Using custom JSONDecoder
    lazy var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    enum APIServiceError: Error {
        case apiError
        case invalidEndpoint
        case invalidResponse
        case noData
        case decodingError
    }
    
    func getSearchResults<T: Decodable>(searchTerm: String, completion: @escaping (Result<T, APIServiceError>) -> Void) {
        
        guard var urlComponents = URLComponents(string: "https://swapi.dev/api/people/") else {
            completion(.failure(APIServiceError.invalidEndpoint))
            return
        }
        let queryItems = [
            URLQueryItem(name: "media", value: "music"),
            URLQueryItem(name: "entity", value: "song"),
            URLQueryItem(name: "term", value: searchTerm),
        ]
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                completion(.failure(.apiError))
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let result = try self.jsonDecoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.decodingError))
            }
            
            
        }.resume()
        
    }
}

