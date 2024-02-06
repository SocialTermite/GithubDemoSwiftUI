//
//  ApiClient.swift
//  GithubDemoSwiftUI
//
//  Created by Konstantin Bondar on 07.02.2024.
//

import Foundation

enum APIError: Error {
    case requestFailed
    case invalidData
}

protocol ApiClient {
    func getEvents() async throws -> [GitHubEvent]
}
