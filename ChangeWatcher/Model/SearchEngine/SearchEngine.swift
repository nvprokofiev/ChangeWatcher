//
//  SearchEngine.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-01-18.
//

import Foundation

protocol SearchEngine {
    var host: String { get }
    var scheme: String { get }
    var path: String { get }
    
    func configureURLComponents(for: String)-> URLComponents
}

extension SearchEngine {
    
    var scheme: String { "https" }
    var defaultComponents: URLComponents {
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.host
        components.path = self.path
        components.queryItems = []
        return components
    }
    
    func buildSearchURLRequest(for query: String)-> URLRequest? {
        let components = configureURLComponents(for: query)
        guard let url = components.url else { return nil }
        return URLRequest(url: url)
    }
}

