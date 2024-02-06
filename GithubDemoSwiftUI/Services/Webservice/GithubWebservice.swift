//
//  GithubWebservice.swift
//  GithubDemoSwiftUI
//
//  Created by Konstantin Bondar on 07.02.2024.
//

import Foundation

class GithubWebservice: WebService {
    let baseURL = "https://api.github.com"
    
    func request<T: Decodable>(_ endpoint: String) async throws -> T {
        guard let url = URL(string: baseURL + endpoint) else {
            throw APIError.requestFailed
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(T.self, from: data)
            return result
        } catch {
            throw APIError.invalidData
        }
    }
}
