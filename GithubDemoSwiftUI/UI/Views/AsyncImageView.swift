//
//  AsyncImageView.swift
//  GithubDemoSwiftUI
//
//  Created by Konstantin Bondar on 07.02.2024.
//

import SwiftUI

struct AsyncImageView: View {
    var url: String?
    
    var body: some View {
        AsyncImage(url: URL(string: url ?? "")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFill()
            } else if phase.error != nil {
                Color.red // Indicates an error.
            } else {
                Color.blue // Acts as a placeholder.
            }
        }
    }
}
