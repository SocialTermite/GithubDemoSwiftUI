//
//  GithubEvent.swift
//  GithubDemoSwiftUI
//
//  Created by Konstantin Bondar on 07.02.2024.
//

import Foundation


struct GitHubEvent: Decodable, Identifiable {
    var id: String = UUID().uuidString
    var type: EventType
    var actor: Actor
}
