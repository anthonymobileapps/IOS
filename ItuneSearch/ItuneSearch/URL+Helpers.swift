//
//  Http+Helpers.swift
//  ItuneSearch
//
//  Created by Anthony Fung on 2019-02-15.
//  Copyright © 2019 mac2_ios. All rights reserved.
//

import Foundation
extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap { URLQueryItem(name: $0.0, value: $0.1)}
        return components?.url
    }
    func withHTTPS() -> URL? {
        
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.scheme = "https"
        return components?.url
    }

}
