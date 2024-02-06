//
//  EventsListViewModel.swift
//  GithubDemoSwiftUI
//
//  Created by Konstantin Bondar on 07.02.2024.
//

import Combine
import Foundation

@MainActor
class EventsListViewModel: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []

    private let apiClient: ApiClient
    
    @Published private var events: [GitHubEvent] = []
    
    init(apiClient: ApiClient = GitHubAPIClient()) {
        self.apiClient = apiClient
        self.createTimer()
    }
    
    @Published var selectedEventType: EventType?
    
    var filteredEvents: [GitHubEvent] {
        if let selectedEventType {
            return events.filter { $0.type == selectedEventType }
        } else {
            return events
        }
    }
    
    @Published private(set) var isRefreshing: Bool = false
    
    private func createTimer() {
        Timer.publish(every: 10, on: .main, in: .default)
             .autoconnect()
             .sink { [weak self] _ in
                 self?.refresh()
             }
             .store(in: &cancellables)
    }
    
    func refresh() {
        self.isRefreshing = true
        Task { [weak self] in
            guard let self else { return }
            do {
                let events = try await self.apiClient.getEvents()
                await MainActor.run {
                    self.events = events
                    self.isRefreshing = false
                }
            } catch {
                print(error)
            }
            
        }
    }
}
