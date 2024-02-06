//
//  Webservice.swift
//  GithubDemoSwiftUI
//
//  Created by Konstantin Bondar on 07.02.2024.
//

import Foundation

protocol WebService {
    func request<T: Decodable>(_ endpoint: String) async throws -> T
}

