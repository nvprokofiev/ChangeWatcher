//
//  GoogleSearchEngine.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-01-19.
//

import Foundation

struct GoogleSearchEngine: SearchEngine {
    
    let host = "google.com"
    let path = "/search"
    
    func configureURLComponents(for query: String) -> URLComponents {
        let queryItem = URLQueryItem(name: "s", value: query)
        var components = defaultComponents
        components.queryItems?.append(queryItem)
        return components
    }
}
