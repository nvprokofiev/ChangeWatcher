//
//  SearchEngine.swift
//  ChangeWatcher
//
//  Created by Nikolai Prokofev on 2021-01-18.
//

import Foundation

enum SearchEngine {
    case google(String)
}

extension SearchEngine {
    
    private var host: String {
        switch self {
        case .google:
            return "google.com"
        }
    }
    
    private var scheme: String {
        switch self {
        case .google:
            return "https"
        }
    }
    
    private var path: String {
        switch self {
        case .google:
            return "/search"
        }
    }
    
    private var queryItems: [URLQueryItem]? {
        switch self {
        case .google(let query):
            
            guard let encoded = query.percentEncoded() else {
                return nil
            }
            
            let item = URLQueryItem(name: "q", value: encoded)
            return [item]
        }
    }
    
    func construcSearchtURL() -> URL? {
        
        guard let queryItems = self.queryItems else { return nil }

        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.host
        components.path = self.path
        components.queryItems = queryItems
        
        return components.url
    }
    
}
