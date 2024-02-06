//
//  EventType.swift
//  GithubDemoSwiftUI
//
//  Created by Konstantin Bondar on 07.02.2024.
//

import Foundation

enum EventType: String, Codable, CaseIterable, Hashable {
    case watch = "WatchEvent"
    case push = "PushEvent"
    case pullRequest = "PullRequestEvent"
    case fork = "ForkEvent"
    case issues = "IssuesEvent"
    case other = "Other"
    
    init(from decoder: Decoder) throws {
        let rawValue = try decoder.singleValueContainer().decode(String.self)
        self = EventType(rawValue: rawValue) ?? .other
    }
}
