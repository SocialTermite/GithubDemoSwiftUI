//
//  GithubAPIClient.swift
//  GithubDemoSwiftUI
//
//  Created by Konstantin Bondar on 07.02.2024.
//

import Foundation

class GitHubAPIClient: ApiClient {
    private let webservice: WebService
    init(webservice: WebService = GithubWebservice()) {
        self.webservice = webservice
    }
    
    func getEvents() async throws -> [GitHubEvent] {
        let eventTypesString = EventType.allCases.map(\.rawValue).joined(separator: ",")
        let endpoint = "/events?per_page=100&type=\(eventTypesString)"
        
        return try await webservice.request(endpoint)
    }
}
