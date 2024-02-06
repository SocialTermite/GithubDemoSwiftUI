//
//  EventDetailsView.swift
//  GithubDemoSwiftUI
//
//  Created by Konstantin Bondar on 07.02.2024.
//

import SwiftUI

struct EventDetailView: View {
    let event: GitHubEvent

    var body: some View {
        VStack {
            Text("Event Type: \(event.type.rawValue)")
                .padding()
            Text("Actor: \(event.actor.login)")
                .padding()

            AsyncImageView(url: event.actor.avatar_url ?? "")
                .frame(width: 150, height: 150)
                .clipShape(Circle())
        }
        .navigationTitle("Event Details")
    }
}
